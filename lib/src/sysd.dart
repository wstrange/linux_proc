import 'package:dbus/dbus.dart';

import 'systemd.dart';

final sysdSvc = SystemD();

class SystemD {
  final client = DBusClient.system();
  late final OrgFreedesktopDBusPeer dbus;

  SystemD() {
    dbus = OrgFreedesktopDBusPeer(
      client,
      'org.freedesktop.systemd1',
      DBusObjectPath('/org/freedesktop/systemd1'),
    );
  }

  Future<List<Service>> getUnits() async {
    var r = await dbus.callListUnits();

    var l = <Service>[];

    // we get back a list of lists
    // for each list
    for (var s in r) {
      // the first item is the list is the unit name as a DBusString..
      if (s.first.asString().endsWith('.service')) {
        l.add(Service.fromDbusValues(s));
      }
    }

    // need to implement comparable first..
    // l.sort();
    return l;
  }
}

class Service {
  final String name;

  Service({required this.name});

  factory Service.fromDbusValues(List<DBusValue> dbus) {
    var x = dbus.first;
    return Service(name: x.asString());
  }
}
