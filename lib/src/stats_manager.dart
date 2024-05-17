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

  /// The most recent stats collected
  late Stats currentStats;

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
    _getStats();
    _stream = _controller.stream.asBroadcastStream();
  }

  void _startTimer() {
    _timer =
        Timer.periodic(Duration(seconds: _refreshTimeSeconds), _getStatsTimer);
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// Resets the refresh interval.
  ///
  /// To pause stats collection, set seconds to 0.
  /// Note if you change the update interval (say from 2 to 4)
  /// you need to collect 2 or more samples for the CPU running stats
  /// to sync up.
  void setRefreshSeconds(int seconds) {
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

  // Keeps track of running CPU stats. This is used
  // to compare the current cpu consumption vs. the previous load N seconds ago
  // when the last sample was taken.
  CPURunningStats? _cpuRunningStats;

  void _getStatsTimer(Timer t) => _getStats();

  void _getStats() {
    var stats = SystemStats.getStats();
    var procs = Process.getAllProcesses();
    var memInfo = getMemoryInfo();

    _cpuRunningStats ??=
        CPURunningStats(stats, procs, _refreshTimeSeconds.toDouble());

    // This will update things like cpuPercentage in the stats and proccess.
    _cpuRunningStats!.update(stats, procs);

    currentStats = Stats(
        stats: stats,
        processes:
            Process.sort(procs.values.toList(), _procSortFn, _sortAscending),
        memInfo: memInfo);

    _controller.add(currentStats);
    statsQueue.addFirst(currentStats);
    if (statsQueue.length > _queueSize) {
      statsQueue.removeLast();
    }
  }
}
