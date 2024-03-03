import 'dart:async';

import 'package:linux_proc/linux_proc.dart';
import 'package:test/test.dart';

main() async {
  test('systems stats', () async {
    var stats = await SystemStats.getStats();

    expect(stats.cpu.idle, isNonNegative);

    print('Stats = $stats');
  });

  test('Stats stream', () async {
    var s = StatsManager();
    Timer(Duration(seconds: 25), () => s.close());

    CPURunningStats? _c;
    await for (var v in s.stream) {
      // ignore: unnecessary_null_comparison
      _c == null ? _c = CPURunningStats(v.stats) : _c.update(v.stats);

      print(_c);

      // print(
      // 'System ${v.stats.systemTimePercentage}  idle  = ${v.stats.idleTimePercent} users-${v.stats.userTimePercentage}');
    }

    print('done');
  });
}
