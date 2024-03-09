import 'dart:async';

import 'package:linux_proc/linux_proc.dart';
import 'package:test/test.dart';

main() async {
  test('systems stats', () async {
    var stats = await SystemStats.getStats();

    expect(stats.cpu.idle, isNonNegative);

    print('S;tats = $stats');
  });

  test('Stats stream', () async {
    var s = StatsManager();
    Timer(Duration(seconds: 25), () => s.close());

    await for (var v in s.stream) {
      var procs = v.processes;
      var stats = v.stats;

      var c = stats.cpuPercentage.toStringAsFixed(1);
      var i = stats.idleTimePercentage.toStringAsFixed(1);
      var sys = stats.systemTimePercentage.toStringAsFixed(1);
      var u = stats.userTimePercentage.toStringAsFixed(1);

      print('Stats cpu $c user $u sys $sys idle: $i');

      // procs.sort((p) => p.cpuPercentage);
    }

    print('done');
  });
}
