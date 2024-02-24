// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:linux_proc/src/systemd.dart';
import 'package:test/test.dart';

main() async {
  test('api', () async {
    var client = DBusClient.system();
    var object = DBusRemoteObject(client,
        name: 'org.freedesktop.hostname1',
        path: DBusObjectPath('/org/freedesktop/hostname1'));
    var hostname =
        await object.getProperty('org.freedesktop.hostname1', 'Hostname');

    print(hostname);
    expect(hostname, isNotNull);
    await client.close();
  });

  test('Systemd API', () async {
    var client = DBusClient.system();
    var sysd = DBusRemoteObject(client,
        name: 'org.freedesktop.systemd1',
        path: DBusObjectPath('/org/freedesktop/systemd1'));

    var m = await sysd.introspect();

    for (var i in m.interfaces) {
      print('${i.name}\n');
      if (i.name.endsWith('Manager')) {
        _printMethods(i.methods);
      }
    }

    List<DBusValue> vals = [];

    var x = await sysd.callMethod(
        'org.freedesktop.systemd1.Manager', 'ListUnits', vals);

    print(x);

    await client.close();
  }, skip: true);

  test('systemd xml', () async {
    var client = DBusClient.system();
    var sysd = DBusRemoteObject(client,
        name: 'org.freedesktop.systemd1',
        path: DBusObjectPath('/org/freedesktop/systemd1'));

    var m = await sysd.introspect();

    var f = File('systemd.xml');
    f.writeAsStringSync('${m.toXml()}');
  }, skip: true);

  test('Generated API test', () async {
    var client = DBusClient.system();

    final f = OrgFreedesktopDBusPeer(
      client,
      'org.freedesktop.systemd1',
      DBusObjectPath('/org/freedesktop/systemd1'),
    );

    var svc = 'demo.service';

    var r = await f.callGetUnitFileState(svc);

    // for (var u in r) {
    //   for (var x in u) {
    //     print(x);
    //   }
    // }

    print('got result $r');

    var r2 = await f.callDisableUnitFiles([svc], true);

    print(r2);

    var x = await f.callGetUnit(svc);

    print(x);

    // var u = await f.callGetUnit('name');

    await client.close();
  });
}

_printMethods(List<DBusIntrospectMethod> methods) {
  for (var m in methods) {
    print('${m.name}  ${_summarizeArgs(m.args)}');
  }
}

String _summarizeArgs(List<DBusIntrospectArgument> args) {
  var s = '';
  for (var a in args) {
    s += '${a.name}, ';
  }
  return s;
}
