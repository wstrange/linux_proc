import 'package:test/test.dart';
import 'package:linux_proc/linux_proc.dart';

main() {
  test('Dbus stat', () async {
    var sd = SystemD();

    var r = await sd.stopUnit('demo.service');
    print(r);
  });
}
