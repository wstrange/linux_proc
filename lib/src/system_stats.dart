// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:collection';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

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

  static Future<SystemStats> getStats() async {
    var b = await _statsFile.readAsBytes();
    return SystemStats.fromBuffer(b);
  }

  @override
  String toString() => 'SystemsStats(cpu: $cpu)';
  static final _statsFile = File('/proc/stat');
}

/// Keep a running track of cpu status
///
class CPURunningStats {
  SystemStats _prev;
  SystemStats _current;

  CPURunningStats(this._prev) : _current = _prev;

  update(SystemStats newStats) {
    _prev = _current;
    _current = newStats;
  }

  // get the diff of total cpu time - but gaurd against a 0 value
  // which happens the first time before update is called.
  int get totalDiff => _current.totalTime - _prev.totalTime == 0
      ? 1
      : _current.totalTime - _prev.totalTime;

  int get idleDiff => _current.idleAllTime - _prev.idleAllTime;

  double get cpuPercentage => (totalDiff - idleDiff) / totalDiff * 100.0;

  double get userTimePercentage =>
      (_current.totalUserTime - _prev.totalUserTime) / totalDiff * 100.0;
  double get systemTimePercentage =>
      (_current.systemAllTime - _prev.systemAllTime) / totalDiff * 100.0;

  double get idleTimePercentage =>
      (_current.idleAllTime - _prev.idleAllTime) / totalDiff * 100.0;

  @override
  String toString() =>
      'us: ${userTimePercentage.toStringAsFixed(1)} sys ${systemTimePercentage.toStringAsFixed(1)}  id: ${idleTimePercentage.toStringAsFixed(1)}';
}
