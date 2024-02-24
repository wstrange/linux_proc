import 'package:linux_proc/linux_proc.dart';
import 'package:test/test.dart';

main() async {
  test('Read passwd map', () async {
    var pw = await Passwd.getPasswdMap();

    for (var e in pw.entries) {
      print(e.value);
    }

    var root = await Passwd.getPasswdEntry(0);
    expect(root, isNotNull);
    var r = root!;
    expect(r.uid, equals(0));
    expect(r.primaryGid, equals(0));
    expect(r.homeDirPath, equals('/root'));
  });
}
