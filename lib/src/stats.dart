// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:linux_proc/src/cpu_running_stats.dart';

import 'process.dart';
import 'system_stats.dart';

typedef Stats = ({
  SystemStats stats,
  List<Process> processes,
});

/// All the stats
class StatsManager {
  late Timer timer;
  final _controller = StreamController<Stats>();
  CPURunningStats? _cpuRunningStats;
  final int refreshTimeSeconds;

  StatsManager({required this.refreshTimeSeconds}) {
    timer = Timer.periodic(
        Duration(seconds: refreshTimeSeconds), (_) => _getStats());
    _controller.onCancel = () => timer.cancel();
  }

  Stream<Stats> get stream => _controller.stream;

  void _getStats() async {
    var stats = await SystemStats.getStats();
    var procs = await Process.getAllProcesses();
    _cpuRunningStats ??=
        CPURunningStats(stats, procs, refreshTimeSeconds.toDouble());
    _cpuRunningStats!.update(stats, procs);

    _controller.add((
      stats: stats,
      processes: procs.values.toList(),
    ));
  }

  void close() {
    _controller.close();
  }
}
