// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:collection';
import 'cpu_running_stats.dart';
import 'mem_info.dart';
import 'process.dart';
import 'system_stats.dart';

/// A collection of Linux statistics taken at a point in time
class Stats {
  /// System level stats (CPU load, etc.)
  final SystemStats stats;

  /// List of currently running [Process].
  final List<Process> processes;

  /// Current memory information [MemInfo]
  final MemInfo memInfo;

  Stats({required this.stats, required this.processes, required this.memInfo});
}

/// Manage a stream of [Stats] updates.
///
/// [Stats] are returned as a broadcast stream
/// This is what most consumers will want.
/// Every N seconds, a record containing all the stats and processes
/// is returned to the stream.
///
class StatsManager {
  Timer? _timer;
  late StreamController<Stats> _controller;
  late Stream<Stats> _stream;
  final statsQueue = Queue<Stats>();
  final int _queueSize;

  CPURunningStats? _cpuRunningStats;
  int _refreshTimeSeconds;
  // The default sort function for processes
  ProcessField _procSortFn = (p) => p.cpuPercentage;
  bool _sortAscending = false;

  /// Create a Linux Stats Manager.
  /// New stats will be sent to the stream every [refreshTimeSeconds]
  /// The [statsQueue] maintains a queue of the last N results, up to
  /// a maximum of [queueSize]
  StatsManager({int refreshTimeSeconds = 4, int queueSize = 100})
      : _queueSize = queueSize,
        _refreshTimeSeconds = refreshTimeSeconds {
    _controller = StreamController<Stats>(
      onListen: _startTimer,
      onPause: _stopTimer,
      onResume: _startTimer,
      onCancel: _stopTimer,
    );
    _stream = _controller.stream.asBroadcastStream();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: _refreshTimeSeconds), _getStats);
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// Resets the refresh interval.
  ///
  /// To pause stats collection, set seconds to 0.
  void setRefreshSeonds(int seconds) {
    _stopTimer();
    _refreshTimeSeconds = seconds;
    if (seconds > 0) {
      _startTimer();
    }
  }

  /// The broadcast stream of Stats updates
  ///
  Stream<Stats> get stream => _stream;

  // Set the sort order for the List of processes
  // This will take effect as soon as the next results are returned.
  // The default sort order is cpuPercentage.

  // [ProcessField] is a getter that returns the process field in question
  // (it must implement the [Comparable] interface).
  // [asc] if true, sort in ascending order.
  //
  // For example, to sort by process id:
  //   `this.setSortOrder( (Process p) => p.procPid, true)`
  void setProcessSortOrder(ProcessField fn, bool asc) {
    _procSortFn = fn;
    _sortAscending = asc;
  }

  void _getStats(Timer t) async {
    var stats = await SystemStats.getStats();
    var procs = await Process.getAllProcesses();
    var memInfo = await getMemoryInfo();

    _cpuRunningStats ??=
        CPURunningStats(stats, procs, _refreshTimeSeconds.toDouble());
    _cpuRunningStats!.update(stats, procs);

    final s = Stats(
        stats: stats,
        processes:
            Process.sort(procs.values.toList(), _procSortFn, _sortAscending),
        memInfo: memInfo);

    _controller.add(s);
    statsQueue.addFirst(s);
    if (statsQueue.length > _queueSize) {
      statsQueue.removeLast();
    }
  }
}
