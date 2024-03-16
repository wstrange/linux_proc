import 'dart:async';

import 'package:linux_proc/linux_proc.dart';
import 'package:test/test.dart';

main() async {
  test('systems stats', () async {
    var stats = await SystemStats.getStats();

    expect(stats.cpu.idle, isNonNegative);

    print('S;tats = $stats');
  }, skip: true);

  test('Stats stream', () async {
    var s = StatsManager(refreshTimeSeconds: 2);
    Timer(Duration(seconds: 25), () => s.close());

    await for (var v in s.stream) {
      var procs = v.processes;
      var stats = v.stats;

      var i = stats.idleTimePercentage.toStringAsFixed(1);
      var sys = stats.systemTimePercentage.toStringAsFixed(1);
      var u = stats.userTimePercentage.toStringAsFixed(1);

      print('Stats cpu user $u sys $sys idle: $i');

      // Sort the process by cpu
      Process.sort(procs, (p) => p.cpuPercentage, false);

      // int count = 0;

      for (final p in procs) {
        print(
            '${p.procPid} ${p.command} ${p.cpuPercentage.toStringAsFixed(1)}%  u:${p.userTime} s:${p.systemTime}');
        // print(p);
        // if (++count > 20) break;
      }
    }

    print('done');
  });
}
