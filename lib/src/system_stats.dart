// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'process.dart';

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

  /// The following attributes are virtual and can
  /// only be calculated once we have another sample to compare against.
  /// see [updatePercentageStats]
  ///
  double cpuPercentage = 0.0;
  double userTimePercentage = 0.0;
  double systemTimePercentage = 0.0;
  double idleTimePercentage = 0.0;

  /// Given a previous sample [prev], calculate the
  /// difference in cpu consumption over the time period.
  /// Note the period of time does not matter so much
  /// as we are looking at the relative values of idle vs system vs user
  updatePercentageStats(SystemStats prev) {
    // get the diff of total cpu time - but gaurd against a 0 value
    // which happens the first time before update is called.
    var totalDiff = totalTime - prev.totalTime;

    var idleDiff = idleAllTime - prev.idleAllTime;

    cpuPercentage = (totalDiff - idleDiff) / totalDiff * 100.0;

    userTimePercentage =
        (totalUserTime - prev.totalUserTime) / totalDiff * 100.0;
    systemTimePercentage =
        (systemAllTime - prev.systemAllTime) / totalDiff * 100.0;
    idleTimePercentage = (idleAllTime - prev.idleAllTime) / totalDiff * 100.0;
  }

  @override
  String toString() => 'SystemsStats(cpu: $cpu)';

  static final _statsFile = File('/proc/stat');
}

/// Keep a running track of cpu status
///
class CPURunningStats {
  SystemStats _stats;
  Map<int, Process> _process;

  CPURunningStats(this._stats, this._process);

  // Update the cpu and process percentages by comparing
  // against the previous sample.

  update(SystemStats newStats, Map<int, Process> processMap) {
    // measure total cpu consumption by taking the diff
    // this value is the number of jiffies
    final systemCPUdiff = newStats.totalCPU - _stats.totalCPU;

    // For each process.
    for (var MapEntry(key: pid, value: process) in processMap.entries) {
      var op = _process[pid];
      if (op == null) continue; // process possibly new

      // Set the processes cpu percentage so we can sort on it later
      process.updateCPUPercentage(op, systemCPUdiff);
    }

    newStats.updatePercentageStats(_stats);
    _process = processMap;
    _stats = newStats;
  }
}
