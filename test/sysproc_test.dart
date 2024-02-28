import 'dart:async';

import 'package:linux_proc/linux_proc.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'dart:typed_data';

main() async {
  test('systems stats', () async {
    var stats = await SystemStats.getStats();

    expect(stats.cpu.idle, isNonNegative);

    print('Stats = $stats');
  });

  test('Stats stream', () async {
    var s = StatsManager();
    Timer(Duration(seconds: 20), () => s.cancel());

    await for (var v in s.stream) {
      print('Got value ${v.stats.cpu}  idle  = ${v.stats.idleTimePercent}');
    }

    print('done');
  });
}
