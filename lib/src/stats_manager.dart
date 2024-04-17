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
  Timer? timer;
  late StreamController<Stats> controller;
  late Stream<Stats> _stream;

  CPURunningStats? _cpuRunningStats;
  final int refreshTimeSeconds;
  // The default sort function for processes
  ProcessField _procSortFn = (p) => p.cpuPercentage;
  bool _sortAscending = false;

  StatsManager({required this.refreshTimeSeconds}) {
    controller = StreamController<Stats>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer,
    );
    _stream = controller.stream.asBroadcastStream();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: refreshTimeSeconds), _getStats);
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  Stream<Stats> get stream => _stream;

  // Set the sort order for the processes
  // This will take effect as soon as the next results are returned.
  // The default sort order is cpuPercentage.
  //
  // Example:   this.setSortOrder( (Process p) => p.procPid, true)
  void setSortOrder(ProcessField fn, bool asc) {
    _procSortFn = fn;
    _sortAscending = asc;
  }

  void _getStats(Timer t) async {
    var stats = await SystemStats.getStats();
    var procs = await Process.getAllProcesses();
    var memInfo = await getMemoryInfo();

    _cpuRunningStats ??=
        CPURunningStats(stats, procs, refreshTimeSeconds.toDouble());
    _cpuRunningStats!.update(stats, procs);

    controller.add((
      stats: stats,
      processes:
          Process.sort(procs.values.toList(), _procSortFn, _sortAscending),
      memInfo: memInfo,
    ));
  }
}
