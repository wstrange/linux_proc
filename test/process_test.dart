import 'package:test/test.dart';
import 'package:linux_proc/linux_proc.dart';
import 'dart:io';

main() async {
  test('Process Test', () async {
    var stopwatch = Stopwatch();

    // see how long it takes for multiple iterations..
    for (int i = 0; i < 1; ++i) {
      stopwatch.reset();
      stopwatch.start();
      var map = await Process.getAllProcesses();
      var m = map.values.toList();

      // Process.sort(m, (p) => p.command, true);
      Process.sort(m, (p) => p.userTime, true);
      print(
          'fetched ${m.length} process in ${stopwatch.elapsedMilliseconds}ms');
      expect(m, isNotNull);
      expect(m.length > 10, isTrue);

      for (var p in m) {
        print('${p.procPid}: ${p.command} u: ${p.userTime}');
      }
    }
  });

  test('parse status', () async {
    var m = await parseProcStatus(pid);

    print('Got process status m: $m');
    expect(m['Pid'], equals(pid));
  });

  test('Get current process', () async {
    var p = await Process.getProcess(pid);
    expect(p, isNotNull);
    expect(p!.procPid, equals(pid));
  });
}
