// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'cpu_running_stats.dart';
import 'mem_info.dart';
import 'process.dart';
import 'system_stats.dart';

typedef Stats = ({
  SystemStats stats,
  List<Process> processes,
  MemInfo memInfo,
});

/// All the stats returned as a stream
/// This is what most consumers will want.
/// Every N seconds, a record containing all the stats and processes
/// is returned to the stream.
///
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
    var memInfo = await getMemoryInfo();

    _cpuRunningStats ??=
        CPURunningStats(stats, procs, refreshTimeSeconds.toDouble());
    _cpuRunningStats!.update(stats, procs);

    _controller.add((
      stats: stats,
      processes: procs.values.toList(),
      memInfo: memInfo,
    ));
  }

  void close() {
    _controller.close();
  }
}
