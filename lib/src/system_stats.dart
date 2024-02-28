// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
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
///
class SystemStats {
  final CPUMetrics cpu;
  final List<CPUMetrics> cpus;
  final int procsRunning;
  final int procsBlocked;
  SystemStats({
    required this.cpu,
    required this.cpus,
    required this.procsRunning,
    required this.procsBlocked,
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

    return SystemStats(cpu: cpu, cpus: l, procsRunning: 0, procsBlocked: 0);
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

  double get idleTimePercent => ((cpu.idle * 100.0) / totalCPU);

  static CPUMetrics _parseCPU(String l) {
    var p = l.split(RegExp(r'\s+'));

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

  static int _getInt(String t) => int.tryParse(t) ?? 0;

  static Future<SystemStats> getStats() async {
    var b = await _statsFile.readAsBytes();
    return SystemStats.fromBuffer(b);
  }

  @override
  String toString() => 'SystemsStats(cpu: $cpu)';
  static final _statsFile = File('/proc/stat');
}
