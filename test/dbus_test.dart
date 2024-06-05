import 'package:test/test.dart';
import 'package:linux_proc/linux_proc.dart';

final testSvc = 'demo.service';
main() {
  var sd = SystemD();

  test('List Dbus', () async {
    var l = await sd.getUnits();
    for (var s in l) {
      print('${s.unitName} ${s.active} ${s.subState}');
    }
  });
  test('Dbus stat', () async {
    var r = await sd.stopUnit(testSvc);
    print(r);

    await Future.delayed(Duration(seconds: 5));

    r = await sd.startUnit(testSvc);
    print(r);

    r = await sd.getUnit(testSvc);
    print(r);
  });
}
