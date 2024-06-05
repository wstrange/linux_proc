// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dbus/dbus.dart';

import 'systemd.dart';

final sysdSvc = SystemD();

/// DBus modes:
///  The mode needs to be one of replace, fail, isolate, ignore-dependencies, ignore-requirements.
enum Mode {
  // start the unit and its dependencies, possibly replacing already queued jobs that conflict with this.
  replace,
  // start the unit and its dependencies, but will fail if this would change an already queued job
  fail,
  // start the unit in question and terminate all units that aren't dependencies of it.
  // This is invalid for stopUnit
  isolate,

  /// It is not recommended to make use of the latter two options
  /// Note - these need to be lower cased with a dash to seperate the names
  /// ignore-dependencies - start a unit but ignore all its dependencies
  ignoreDependencies,
  // start a unit but only ignore the requirement dependencies
  ignoreRequirements,
}

/// SystemD Dbus interface
/// See https://www.freedesktop.org/wiki/Software/systemd/dbus/
///
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

    l.sort(); // Sort by Service unitName
    return l;
  }

  Future<String> getUnit(String serviceName) async {
    var r = await dbus.callGetUnit(serviceName);
    print(r);
    return r.value;
  }

  Future<String> stopUnit(String serviceName,
      {Mode mode = Mode.replace}) async {
    var r = await dbus.callStopUnit(serviceName, mode.name);
    return r.value;
  }

  Future<String> startUnit(String serviceName,
      {Mode mode = Mode.replace}) async {
    var r = await dbus.callStartUnit(serviceName, mode.name);
    return r.value;
  }
}

class Service implements Comparable<Service> {
  final String unitName;
  final String description;
  final String loadeState;
  final String active;
  final String subState;
  final String objectPath;
  Service({
    required this.unitName,
    required this.description,
    required this.loadeState,
    required this.active,
    required this.subState,
    required this.objectPath,
  });

  factory Service.fromDbusValues(List<DBusValue> dbus) {
    return Service(
        unitName: dbus[0].asString(),
        description: dbus[1].asString(),
        loadeState: dbus[2].asString(),
        active: dbus[3].asString(),
        subState: dbus[4].asString(),
        objectPath: dbus[5].asString());
  }

  Service copyWith({
    String? unitName,
    String? description,
    String? loadeState,
    String? active,
    String? subState,
    String? objectPath,
  }) {
    return Service(
      unitName: unitName ?? this.unitName,
      description: description ?? this.description,
      loadeState: loadeState ?? this.loadeState,
      active: active ?? this.active,
      subState: subState ?? this.subState,
      objectPath: objectPath ?? this.objectPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': unitName,
      'description': description,
      'loadeState': loadeState,
      'active': active,
      'subState': subState,
      'objectPath': objectPath,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      unitName: map['name'] as String,
      description: map['description'] as String,
      loadeState: map['loadeState'] as String,
      active: map['active'] as String,
      subState: map['subState'] as String,
      objectPath: map['objectPath'] as String,
    );
  }

  @override
  bool operator ==(covariant Service other) {
    if (identical(this, other)) return true;

    return other.unitName == unitName &&
        other.description == description &&
        other.loadeState == loadeState &&
        other.active == active &&
        other.subState == subState &&
        other.objectPath == objectPath;
  }

  @override
  int get hashCode {
    return unitName.hashCode ^
        description.hashCode ^
        loadeState.hashCode ^
        active.hashCode ^
        subState.hashCode ^
        objectPath.hashCode;
  }

  @override
  int compareTo(Service other) => unitName.compareTo(other.unitName);

  @override
  String toString() {
    return 'Service(unitName: $unitName, description: $description, loadeState: $loadeState, active: $active, subState: $subState, objectPath: $objectPath)';
  }
}
