import 'package:test/test.dart';
import 'package:linux_proc/linux_proc.dart';

main() async {
  test('Process Test', () async {
    var stopwatch = Stopwatch();

    // see how long it takes for multiple iterations..
    for (int i = 0; i < 10; ++i) {
      stopwatch.reset();
      stopwatch.start();
      var m = await Process.getAllProcesses();
      print(
          'fetched ${m.length} process in ${stopwatch.elapsedMilliseconds}ms');
      expect(m, isNotNull);
      expect(m.length > 10, isTrue);

      for (var p in m) {
        print('${p.pid}: ${p.command}');
      }
    }
  });
}
