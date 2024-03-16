import 'process.dart';
import 'system_stats.dart';

/// Keep a running track of cpu status
/// todo: Make this package private
class CPURunningStats {
  SystemStats _stats;
  Map<int, Process> _process;
  final double _sampleInterval;

  CPURunningStats(this._stats, this._process, this._sampleInterval);

  // Update the cpu and process percentages by comparing
  // against the previous sample.

  update(SystemStats newStats, Map<int, Process> processMap) {
    // measure total cpu consumption by taking the diff
    // this value is the number of jiffies
    // final systemCPUdiff = newStats.totalCPU - _stats.totalCPU;

    // print('diff = $systemCPUdiff');

    // For each process.
    for (var MapEntry(key: pid, value: process) in processMap.entries) {
      var op = _process[pid];
      if (op == null) continue; // process possibly new

      // Set the processes cpu percentage so we can sort on it later
      process.updateCPUPercentage(op, _sampleInterval);
    }

    newStats.updatePercentageStats(_stats);
    _process = processMap;
    _stats = newStats;
  }
}
