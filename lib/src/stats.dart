// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:linux_proc/linux_proc.dart';

typedef Stats = ({SystemStats stats, List<Process> processes});

/// All the stats
class StatsManager {
  late Timer timer;
  StreamController<Stats> controller = StreamController<Stats>();

  StatsManager() {
    timer = Timer.periodic(Duration(seconds: 5), (_) => _getStats());
    controller.onCancel = () => timer.cancel();
  }

  Stream<Stats> get stream => controller.stream;

  void _getStats() async {
    var stats = await SystemStats.getStats();
    var procs = await Process.getAllProcesses();
    controller.add((stats: stats, processes: procs));
  }

  void cancel() {
    controller.close();
  }
}
