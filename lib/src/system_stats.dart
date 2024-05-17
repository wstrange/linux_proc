import 'dart:io';
import 'dart:typed_data';

// A record that reflects the order in which cpu metric in /proc/stat are listed
typedef CPUMetrics = ({
  int user,
  int nice,
  int system,
  int idle,
  int iowait,
  int irq,
  int softirq,
  int steal,
  int guest,
  int guestNice
});

/// See
/// https://www.kernel.org/doc/html/latest/filesystems/proc.html#miscellaneous-kernel-statistics-in-proc-stat
/// https://stackoverflow.com/questions/23367857/accurate-calculation-of-cpu-usage-given-in-percentage-in-linux
///
/// Parses /proc/stat   - system level stats
class SystemStats {
  final CPUMetrics cpu;
  final List<CPUMetrics> cpus;
  final int processes;
  final int procsRunning;
  final int procsBlocked;
  final int ctxSwitch;
  final int bootTimeSeconds; // boot time in seconds since epoch

  SystemStats({
    required this.cpu,
    required this.cpus,
    required this.processes,
    required this.procsRunning,
    required this.procsBlocked,
    required this.ctxSwitch,
    required this.bootTimeSeconds,
  });

  factory SystemStats.fromBuffer(Uint8List buf) {
    var s = String.fromCharCodes(buf);
    var lines = s.split('\n');
    var i = 0;
    // first line is cpu
    var cpu = _parseCPU(lines[i++]);

    List<CPUMetrics> l = [];
    while (lines[i].startsWith('cpu')) {
      l.add(_parseCPU(lines[i++]));
    }

    ++i; // next line is the intr - which we dont care abou right now..

    return SystemStats(
      cpu: cpu,
      cpus: l,
      ctxSwitch: _get2ndValue(lines[i++]),
      bootTimeSeconds: _get2ndValue(lines[i++]),
      processes: _get2ndValue(lines[i++]),
      procsRunning: _get2ndValue(lines[i++]),
      procsBlocked: _get2ndValue(lines[i++]),
    );
  }

  // the sum of all the aggregate cpu work
  int get totalCPU =>
      cpu.user +
      cpu.nice +
      cpu.system +
      cpu.idle +
      cpu.iowait +
      cpu.irq +
      cpu.softirq;

  int get systemTime => cpu.system;
  int get userTime => cpu.user + cpu.guest;
  int get niceTime => cpu.nice - cpu.guestNice;
  int get idleAllTime => cpu.idle + cpu.iowait;
  int get systemAllTime => cpu.system + cpu.irq + cpu.softirq;
  int get virtualTime => cpu.guest + cpu.guestNice;
  int get totalTime =>
      userTime +
      niceTime +
      systemAllTime +
      idleAllTime +
      cpu.steal +
      virtualTime;

  int get nonIdleTime =>
      userTime + niceTime + systemTime + cpu.irq + cpu.softirq + cpu.steal;

  int get totalUserTime => userTime + niceTime;

  static final _whiteSpace = RegExp(r'\s+');

  static CPUMetrics _parseCPU(String l) {
    var p = l.split(_whiteSpace);

    int i = 1; // start...
    return (
      user: _getInt(p[i++]),
      nice: _getInt(p[i++]),
      system: _getInt(p[i++]),
      idle: _getInt(p[i++]),
      iowait: _getInt(p[i++]),
      irq: _getInt(p[i++]),
      softirq: _getInt(p[i++]),
      steal: _getInt(p[i++]),
      guest: _getInt(p[i++]),
      guestNice: _getInt(p[i++]),
    );
  }

  static int _get2ndValue(String l) => _getInt(l.split(_whiteSpace)[1]);
  static int _getInt(String t) => int.tryParse(t) ?? 0;

  static SystemStats getStats() {
    var b = _statsFile.readAsBytesSync();
    return SystemStats.fromBuffer(b);
  }

  /// The following attributes are virtual and can
  /// only be calculated once we have another sample to compare against.
  /// see [updatePercentageStats]
  ///
  double userTimePercentage = 0.0;
  double systemTimePercentage = 0.0;
  double idleTimePercentage = 0.0;

  /// Given a previous sample [prev], calculate the
  /// difference in cpu consumption over the time period.
  /// Note the period of time does not matter so much
  /// as we are looking at the relative values of jiffies over time
  ///
  updatePercentageStats(SystemStats prev) {
    // get the diff of total cpu time - but gaurd against a 0 value
    // which happens the first time before update is called.
    var totalDiff = (totalTime - prev.totalTime).toDouble();

    var idleDiff = (idleAllTime - prev.idleAllTime).toDouble();
    userTimePercentage =
        _naNGuard((totalUserTime - prev.totalUserTime) / totalDiff * 100.0);

    // The very first stats may be a Nan as the previous comparison is missing

    systemTimePercentage =
        _naNGuard((systemAllTime - prev.systemAllTime) / totalDiff * 100.0);

    idleTimePercentage = _naNGuard(idleDiff / totalDiff) * 100.0;
  }

  // We can get wonky values - esp for the very first stat collection
  // where there is no previous result. This "protects" the results
  // by returning a zero.
  double _naNGuard(double x) => x.isNaN ? 0.0 : x;

  @override
  String toString() => 'SystemsStats(cpu: $cpu)';

  static final _statsFile = File('/proc/stat');
}
