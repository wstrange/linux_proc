// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object systemd.xml

// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:dbus/dbus.dart';

/// Signal data for org.freedesktop.DBus.Properties.PropertiesChanged.
class OrgFreedesktopDBusPeerPropertiesChanged extends DBusSignal {
  String get interface_name => values[0].asString();
  Map<String, DBusValue> get changed_properties =>
      values[1].asStringVariantDict();
  List<String> get invalidated_properties => values[2].asStringArray().toList();

  OrgFreedesktopDBusPeerPropertiesChanged(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for org.freedesktop.systemd1.Manager.UnitNew.
class OrgFreedesktopDBusPeerUnitNew extends DBusSignal {
  String get id => values[0].asString();
  DBusObjectPath get unit => values[1].asObjectPath();

  OrgFreedesktopDBusPeerUnitNew(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for org.freedesktop.systemd1.Manager.UnitRemoved.
class OrgFreedesktopDBusPeerUnitRemoved extends DBusSignal {
  String get id => values[0].asString();
  DBusObjectPath get unit => values[1].asObjectPath();

  OrgFreedesktopDBusPeerUnitRemoved(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for org.freedesktop.systemd1.Manager.JobNew.
class OrgFreedesktopDBusPeerJobNew extends DBusSignal {
  int get id => values[0].asUint32();
  DBusObjectPath get job => values[1].asObjectPath();
  String get unit => values[2].asString();

  OrgFreedesktopDBusPeerJobNew(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for org.freedesktop.systemd1.Manager.JobRemoved.
class OrgFreedesktopDBusPeerJobRemoved extends DBusSignal {
  int get id => values[0].asUint32();
  DBusObjectPath get job => values[1].asObjectPath();
  String get unit => values[2].asString();
  String get result => values[3].asString();

  OrgFreedesktopDBusPeerJobRemoved(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for org.freedesktop.systemd1.Manager.StartupFinished.
class OrgFreedesktopDBusPeerStartupFinished extends DBusSignal {
  int get firmware => values[0].asUint64();
  int get loader => values[1].asUint64();
  int get kernel => values[2].asUint64();
  int get initrd => values[3].asUint64();
  int get userspace => values[4].asUint64();
  int get total => values[5].asUint64();

  OrgFreedesktopDBusPeerStartupFinished(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for org.freedesktop.systemd1.Manager.UnitFilesChanged.
class OrgFreedesktopDBusPeerUnitFilesChanged extends DBusSignal {
  OrgFreedesktopDBusPeerUnitFilesChanged(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for org.freedesktop.systemd1.Manager.Reloading.
class OrgFreedesktopDBusPeerReloading extends DBusSignal {
  bool get active => values[0].asBoolean();

  OrgFreedesktopDBusPeerReloading(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

class OrgFreedesktopDBusPeer extends DBusRemoteObject {
  /// Stream of org.freedesktop.DBus.Properties.PropertiesChanged signals.
  //late final Stream<OrgFreedesktopDBusPeerPropertiesChanged> propertiesChanged;

// Warren - changed propertiesChanged ...
  late final Stream<OrgFreedesktopDBusPeerPropertiesChanged>
      WSPropertiesChanged;

  /// Stream of org.freedesktop.systemd1.Manager.UnitNew signals.
  late final Stream<OrgFreedesktopDBusPeerUnitNew> unitNew;

  /// Stream of org.freedesktop.systemd1.Manager.UnitRemoved signals.
  late final Stream<OrgFreedesktopDBusPeerUnitRemoved> unitRemoved;

  /// Stream of org.freedesktop.systemd1.Manager.JobNew signals.
  late final Stream<OrgFreedesktopDBusPeerJobNew> jobNew;

  /// Stream of org.freedesktop.systemd1.Manager.JobRemoved signals.
  late final Stream<OrgFreedesktopDBusPeerJobRemoved> jobRemoved;

  /// Stream of org.freedesktop.systemd1.Manager.StartupFinished signals.
  late final Stream<OrgFreedesktopDBusPeerStartupFinished> startupFinished;

  /// Stream of org.freedesktop.systemd1.Manager.UnitFilesChanged signals.
  late final Stream<OrgFreedesktopDBusPeerUnitFilesChanged> unitFilesChanged;

  /// Stream of org.freedesktop.systemd1.Manager.Reloading signals.
  late final Stream<OrgFreedesktopDBusPeerReloading> reloading;

  OrgFreedesktopDBusPeer(
      DBusClient client, String destination, DBusObjectPath path)
      : super(client, name: destination, path: path) {
    WSPropertiesChanged = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.DBus.Properties',
            name: 'PropertiesChanged',
            signature: DBusSignature('sa{sv}as'))
        .asBroadcastStream()
        .map((signal) => OrgFreedesktopDBusPeerPropertiesChanged(signal));

    unitNew = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.systemd1.Manager',
            name: 'UnitNew',
            signature: DBusSignature('so'))
        .asBroadcastStream()
        .map((signal) => OrgFreedesktopDBusPeerUnitNew(signal));

    unitRemoved = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.systemd1.Manager',
            name: 'UnitRemoved',
            signature: DBusSignature('so'))
        .asBroadcastStream()
        .map((signal) => OrgFreedesktopDBusPeerUnitRemoved(signal));

    jobNew = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.systemd1.Manager',
            name: 'JobNew',
            signature: DBusSignature('uos'))
        .asBroadcastStream()
        .map((signal) => OrgFreedesktopDBusPeerJobNew(signal));

    jobRemoved = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.systemd1.Manager',
            name: 'JobRemoved',
            signature: DBusSignature('uoss'))
        .asBroadcastStream()
        .map((signal) => OrgFreedesktopDBusPeerJobRemoved(signal));

    startupFinished = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.systemd1.Manager',
            name: 'StartupFinished',
            signature: DBusSignature('tttttt'))
        .asBroadcastStream()
        .map((signal) => OrgFreedesktopDBusPeerStartupFinished(signal));

    unitFilesChanged = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.systemd1.Manager',
            name: 'UnitFilesChanged',
            signature: DBusSignature(''))
        .asBroadcastStream()
        .map((signal) => OrgFreedesktopDBusPeerUnitFilesChanged(signal));

    reloading = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'org.freedesktop.systemd1.Manager',
            name: 'Reloading',
            signature: DBusSignature('b'))
        .asBroadcastStream()
        .map((signal) => OrgFreedesktopDBusPeerReloading(signal));
  }

  /// Invokes org.freedesktop.DBus.Peer.Ping()
  Future<void> callPing(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.DBus.Peer', 'Ping', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.DBus.Peer.GetMachineId()
  Future<String> callGetMachineId(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.DBus.Peer', 'GetMachineId', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes org.freedesktop.DBus.Introspectable.Introspect()
  Future<String> callIntrospect(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.DBus.Introspectable', 'Introspect', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes org.freedesktop.DBus.Properties.Get()
  Future<DBusValue> callGet(String interface_name, String property_name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.DBus.Properties', 'Get',
        [DBusString(interface_name), DBusString(property_name)],
        replySignature: DBusSignature('v'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asVariant();
  }

  /// Invokes org.freedesktop.DBus.Properties.GetAll()
  Future<Map<String, DBusValue>> callGetAll(String interface_name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.DBus.Properties', 'GetAll',
        [DBusString(interface_name)],
        replySignature: DBusSignature('a{sv}'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asStringVariantDict();
  }

  /// Invokes org.freedesktop.DBus.Properties.Set()
  Future<void> callSet(
      String interface_name, String property_name, DBusValue value,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.DBus.Properties',
        'Set',
        [
          DBusString(interface_name),
          DBusString(property_name),
          DBusVariant(value)
        ],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Gets org.freedesktop.systemd1.Manager.Version
  Future<String> getVersion() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager', 'Version',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.Features
  Future<String> getFeatures() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'Features',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.Virtualization
  Future<String> getVirtualization() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'Virtualization',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.Architecture
  Future<String> getArchitecture() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'Architecture',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.Tainted
  Future<String> getTainted() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager', 'Tainted',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.FirmwareTimestamp
  Future<int> getFirmwareTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'FirmwareTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.FirmwareTimestampMonotonic
  Future<int> getFirmwareTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'FirmwareTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.LoaderTimestamp
  Future<int> getLoaderTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'LoaderTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.LoaderTimestampMonotonic
  Future<int> getLoaderTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'LoaderTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.KernelTimestamp
  Future<int> getKernelTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'KernelTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.KernelTimestampMonotonic
  Future<int> getKernelTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'KernelTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDTimestamp
  Future<int> getInitRDTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'InitRDTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDTimestampMonotonic
  Future<int> getInitRDTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'InitRDTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.UserspaceTimestamp
  Future<int> getUserspaceTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'UserspaceTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.UserspaceTimestampMonotonic
  Future<int> getUserspaceTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'UserspaceTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.FinishTimestamp
  Future<int> getFinishTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'FinishTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.FinishTimestampMonotonic
  Future<int> getFinishTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'FinishTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.SecurityStartTimestamp
  Future<int> getSecurityStartTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'SecurityStartTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.SecurityStartTimestampMonotonic
  Future<int> getSecurityStartTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'SecurityStartTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.SecurityFinishTimestamp
  Future<int> getSecurityFinishTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'SecurityFinishTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.SecurityFinishTimestampMonotonic
  Future<int> getSecurityFinishTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'SecurityFinishTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.GeneratorsStartTimestamp
  Future<int> getGeneratorsStartTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'GeneratorsStartTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.GeneratorsStartTimestampMonotonic
  Future<int> getGeneratorsStartTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'GeneratorsStartTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.GeneratorsFinishTimestamp
  Future<int> getGeneratorsFinishTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'GeneratorsFinishTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.GeneratorsFinishTimestampMonotonic
  Future<int> getGeneratorsFinishTimestampMonotonic() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager',
        'GeneratorsFinishTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.UnitsLoadStartTimestamp
  Future<int> getUnitsLoadStartTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'UnitsLoadStartTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.UnitsLoadStartTimestampMonotonic
  Future<int> getUnitsLoadStartTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'UnitsLoadStartTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.UnitsLoadFinishTimestamp
  Future<int> getUnitsLoadFinishTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'UnitsLoadFinishTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.UnitsLoadFinishTimestampMonotonic
  Future<int> getUnitsLoadFinishTimestampMonotonic() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'UnitsLoadFinishTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDSecurityStartTimestamp
  Future<int> getInitRDSecurityStartTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'InitRDSecurityStartTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDSecurityStartTimestampMonotonic
  Future<int> getInitRDSecurityStartTimestampMonotonic() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager',
        'InitRDSecurityStartTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDSecurityFinishTimestamp
  Future<int> getInitRDSecurityFinishTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'InitRDSecurityFinishTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDSecurityFinishTimestampMonotonic
  Future<int> getInitRDSecurityFinishTimestampMonotonic() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager',
        'InitRDSecurityFinishTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDGeneratorsStartTimestamp
  Future<int> getInitRDGeneratorsStartTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'InitRDGeneratorsStartTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDGeneratorsStartTimestampMonotonic
  Future<int> getInitRDGeneratorsStartTimestampMonotonic() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager',
        'InitRDGeneratorsStartTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDGeneratorsFinishTimestamp
  Future<int> getInitRDGeneratorsFinishTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'InitRDGeneratorsFinishTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDGeneratorsFinishTimestampMonotonic
  Future<int> getInitRDGeneratorsFinishTimestampMonotonic() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager',
        'InitRDGeneratorsFinishTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDUnitsLoadStartTimestamp
  Future<int> getInitRDUnitsLoadStartTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'InitRDUnitsLoadStartTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDUnitsLoadStartTimestampMonotonic
  Future<int> getInitRDUnitsLoadStartTimestampMonotonic() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager',
        'InitRDUnitsLoadStartTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDUnitsLoadFinishTimestamp
  Future<int> getInitRDUnitsLoadFinishTimestamp() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'InitRDUnitsLoadFinishTimestamp',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.InitRDUnitsLoadFinishTimestampMonotonic
  Future<int> getInitRDUnitsLoadFinishTimestampMonotonic() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager',
        'InitRDUnitsLoadFinishTimestampMonotonic',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.LogLevel
  Future<String> getLogLevel() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'LogLevel',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Sets org.freedesktop.systemd1.Manager.LogLevel
  Future<void> setLogLevel(String value) async {
    await setProperty(
        'org.freedesktop.systemd1.Manager', 'LogLevel', DBusString(value));
  }

  /// Gets org.freedesktop.systemd1.Manager.LogTarget
  Future<String> getLogTarget() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'LogTarget',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Sets org.freedesktop.systemd1.Manager.LogTarget
  Future<void> setLogTarget(String value) async {
    await setProperty(
        'org.freedesktop.systemd1.Manager', 'LogTarget', DBusString(value));
  }

  /// Gets org.freedesktop.systemd1.Manager.NNames
  Future<int> getNNames() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager', 'NNames',
        signature: DBusSignature('u'));
    return value.asUint32();
  }

  /// Gets org.freedesktop.systemd1.Manager.NFailedUnits
  Future<int> getNFailedUnits() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'NFailedUnits',
        signature: DBusSignature('u'));
    return value.asUint32();
  }

  /// Gets org.freedesktop.systemd1.Manager.NJobs
  Future<int> getNJobs() async {
    var value = await getProperty('org.freedesktop.systemd1.Manager', 'NJobs',
        signature: DBusSignature('u'));
    return value.asUint32();
  }

  /// Gets org.freedesktop.systemd1.Manager.NInstalledJobs
  Future<int> getNInstalledJobs() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'NInstalledJobs',
        signature: DBusSignature('u'));
    return value.asUint32();
  }

  /// Gets org.freedesktop.systemd1.Manager.NFailedJobs
  Future<int> getNFailedJobs() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'NFailedJobs',
        signature: DBusSignature('u'));
    return value.asUint32();
  }

  /// Gets org.freedesktop.systemd1.Manager.Progress
  Future<double> getProgress() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'Progress',
        signature: DBusSignature('d'));
    return value.asDouble();
  }

  /// Gets org.freedesktop.systemd1.Manager.Environment
  Future<List<String>> getEnvironment() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'Environment',
        signature: DBusSignature('as'));
    return value.asStringArray().toList();
  }

  /// Gets org.freedesktop.systemd1.Manager.ConfirmSpawn
  Future<bool> getConfirmSpawn() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'ConfirmSpawn',
        signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.systemd1.Manager.ShowStatus
  Future<bool> getShowStatus() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'ShowStatus',
        signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.systemd1.Manager.UnitPath
  Future<List<String>> getUnitPath() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'UnitPath',
        signature: DBusSignature('as'));
    return value.asStringArray().toList();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultStandardOutput
  Future<String> getDefaultStandardOutput() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultStandardOutput',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultStandardError
  Future<String> getDefaultStandardError() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultStandardError',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.RuntimeWatchdogUSec
  Future<int> getRuntimeWatchdogUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'RuntimeWatchdogUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Sets org.freedesktop.systemd1.Manager.RuntimeWatchdogUSec
  Future<void> setRuntimeWatchdogUSec(int value) async {
    await setProperty('org.freedesktop.systemd1.Manager', 'RuntimeWatchdogUSec',
        DBusUint64(value));
  }

  /// Gets org.freedesktop.systemd1.Manager.RebootWatchdogUSec
  Future<int> getRebootWatchdogUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'RebootWatchdogUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Sets org.freedesktop.systemd1.Manager.RebootWatchdogUSec
  Future<void> setRebootWatchdogUSec(int value) async {
    await setProperty('org.freedesktop.systemd1.Manager', 'RebootWatchdogUSec',
        DBusUint64(value));
  }

  /// Gets org.freedesktop.systemd1.Manager.KExecWatchdogUSec
  Future<int> getKExecWatchdogUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'KExecWatchdogUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Sets org.freedesktop.systemd1.Manager.KExecWatchdogUSec
  Future<void> setKExecWatchdogUSec(int value) async {
    await setProperty('org.freedesktop.systemd1.Manager', 'KExecWatchdogUSec',
        DBusUint64(value));
  }

  /// Gets org.freedesktop.systemd1.Manager.ServiceWatchdogs
  Future<bool> getServiceWatchdogs() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'ServiceWatchdogs',
        signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Sets org.freedesktop.systemd1.Manager.ServiceWatchdogs
  Future<void> setServiceWatchdogs(bool value) async {
    await setProperty('org.freedesktop.systemd1.Manager', 'ServiceWatchdogs',
        DBusBoolean(value));
  }

  /// Gets org.freedesktop.systemd1.Manager.ControlGroup
  Future<String> getControlGroup() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'ControlGroup',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.SystemState
  Future<String> getSystemState() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'SystemState',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.ExitCode
  Future<int> getExitCode() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'ExitCode',
        signature: DBusSignature('y'));
    return value.asByte();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultTimerAccuracyUSec
  Future<int> getDefaultTimerAccuracyUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultTimerAccuracyUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultTimeoutStartUSec
  Future<int> getDefaultTimeoutStartUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultTimeoutStartUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultTimeoutStopUSec
  Future<int> getDefaultTimeoutStopUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultTimeoutStopUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultTimeoutAbortUSec
  Future<int> getDefaultTimeoutAbortUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultTimeoutAbortUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultRestartUSec
  Future<int> getDefaultRestartUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultRestartUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultStartLimitIntervalUSec
  Future<int> getDefaultStartLimitIntervalUSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultStartLimitIntervalUSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultStartLimitBurst
  Future<int> getDefaultStartLimitBurst() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultStartLimitBurst',
        signature: DBusSignature('u'));
    return value.asUint32();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultCPUAccounting
  Future<bool> getDefaultCPUAccounting() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultCPUAccounting',
        signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultBlockIOAccounting
  Future<bool> getDefaultBlockIOAccounting() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultBlockIOAccounting',
        signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultMemoryAccounting
  Future<bool> getDefaultMemoryAccounting() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultMemoryAccounting',
        signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultTasksAccounting
  Future<bool> getDefaultTasksAccounting() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultTasksAccounting',
        signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitCPU
  Future<int> getDefaultLimitCPU() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitCPU',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitCPUSoft
  Future<int> getDefaultLimitCPUSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitCPUSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitFSIZE
  Future<int> getDefaultLimitFSIZE() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitFSIZE',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitFSIZESoft
  Future<int> getDefaultLimitFSIZESoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitFSIZESoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitDATA
  Future<int> getDefaultLimitDATA() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitDATA',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitDATASoft
  Future<int> getDefaultLimitDATASoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitDATASoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitSTACK
  Future<int> getDefaultLimitSTACK() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitSTACK',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitSTACKSoft
  Future<int> getDefaultLimitSTACKSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitSTACKSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitCORE
  Future<int> getDefaultLimitCORE() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitCORE',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitCORESoft
  Future<int> getDefaultLimitCORESoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitCORESoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitRSS
  Future<int> getDefaultLimitRSS() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitRSS',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitRSSSoft
  Future<int> getDefaultLimitRSSSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitRSSSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitNOFILE
  Future<int> getDefaultLimitNOFILE() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitNOFILE',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitNOFILESoft
  Future<int> getDefaultLimitNOFILESoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitNOFILESoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitAS
  Future<int> getDefaultLimitAS() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitAS',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitASSoft
  Future<int> getDefaultLimitASSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitASSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitNPROC
  Future<int> getDefaultLimitNPROC() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitNPROC',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitNPROCSoft
  Future<int> getDefaultLimitNPROCSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitNPROCSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitMEMLOCK
  Future<int> getDefaultLimitMEMLOCK() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitMEMLOCK',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitMEMLOCKSoft
  Future<int> getDefaultLimitMEMLOCKSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitMEMLOCKSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitLOCKS
  Future<int> getDefaultLimitLOCKS() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitLOCKS',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitLOCKSSoft
  Future<int> getDefaultLimitLOCKSSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitLOCKSSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitSIGPENDING
  Future<int> getDefaultLimitSIGPENDING() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitSIGPENDING',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitSIGPENDINGSoft
  Future<int> getDefaultLimitSIGPENDINGSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitSIGPENDINGSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitMSGQUEUE
  Future<int> getDefaultLimitMSGQUEUE() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitMSGQUEUE',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitMSGQUEUESoft
  Future<int> getDefaultLimitMSGQUEUESoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitMSGQUEUESoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitNICE
  Future<int> getDefaultLimitNICE() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitNICE',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitNICESoft
  Future<int> getDefaultLimitNICESoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitNICESoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitRTPRIO
  Future<int> getDefaultLimitRTPRIO() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitRTPRIO',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitRTPRIOSoft
  Future<int> getDefaultLimitRTPRIOSoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitRTPRIOSoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitRTTIME
  Future<int> getDefaultLimitRTTIME() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitRTTIME',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultLimitRTTIMESoft
  Future<int> getDefaultLimitRTTIMESoft() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultLimitRTTIMESoft',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultTasksMax
  Future<int> getDefaultTasksMax() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultTasksMax',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.TimerSlackNSec
  Future<int> getTimerSlackNSec() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'TimerSlackNSec',
        signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.systemd1.Manager.DefaultOOMPolicy
  Future<String> getDefaultOOMPolicy() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'DefaultOOMPolicy',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.systemd1.Manager.CtrlAltDelBurstAction
  Future<String> getCtrlAltDelBurstAction() async {
    var value = await getProperty(
        'org.freedesktop.systemd1.Manager', 'CtrlAltDelBurstAction',
        signature: DBusSignature('s'));
    return value.asString();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetUnit()
  Future<DBusObjectPath> callGetUnit(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'GetUnit', [DBusString(name)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetUnitByPID()
  Future<DBusObjectPath> callGetUnitByPID(int pid,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'GetUnitByPID', [DBusUint32(pid)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetUnitByInvocationID()
  Future<DBusObjectPath> callGetUnitByInvocationID(List<int> invocation_id,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'GetUnitByInvocationID', [DBusArray.byte(invocation_id)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetUnitByControlGroup()
  Future<DBusObjectPath> callGetUnitByControlGroup(String cgroup,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'GetUnitByControlGroup', [DBusString(cgroup)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.LoadUnit()
  Future<DBusObjectPath> callLoadUnit(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'LoadUnit', [DBusString(name)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.StartUnit()
  Future<DBusObjectPath> callStartUnit(String name, String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'StartUnit', [DBusString(name), DBusString(mode)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.StartUnitReplace()
  Future<DBusObjectPath> callStartUnitReplace(
      String old_unit, String new_unit, String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'StartUnitReplace',
        [DBusString(old_unit), DBusString(new_unit), DBusString(mode)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.StopUnit()
  Future<DBusObjectPath> callStopUnit(String name, String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'StopUnit', [DBusString(name), DBusString(mode)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ReloadUnit()
  Future<DBusObjectPath> callReloadUnit(String name, String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'ReloadUnit', [DBusString(name), DBusString(mode)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.RestartUnit()
  Future<DBusObjectPath> callRestartUnit(String name, String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'RestartUnit', [DBusString(name), DBusString(mode)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.TryRestartUnit()
  Future<DBusObjectPath> callTryRestartUnit(String name, String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'TryRestartUnit', [DBusString(name), DBusString(mode)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ReloadOrRestartUnit()
  Future<DBusObjectPath> callReloadOrRestartUnit(String name, String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'ReloadOrRestartUnit', [DBusString(name), DBusString(mode)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ReloadOrTryRestartUnit()
  Future<DBusObjectPath> callReloadOrTryRestartUnit(String name, String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'ReloadOrTryRestartUnit', [DBusString(name), DBusString(mode)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.EnqueueUnitJob()
  Future<List<DBusValue>> callEnqueueUnitJob(
      String name, String job_type, String job_mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'EnqueueUnitJob',
        [DBusString(name), DBusString(job_type), DBusString(job_mode)],
        replySignature: DBusSignature('uososa(uosos)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.freedesktop.systemd1.Manager.KillUnit()
  Future<void> callKillUnit(String name, String whom, int signal,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'KillUnit',
        [DBusString(name), DBusString(whom), DBusInt32(signal)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.CleanUnit()
  Future<void> callCleanUnit(String name, List<String> mask,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'CleanUnit',
        [DBusString(name), DBusArray.string(mask)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.FreezeUnit()
  Future<void> callFreezeUnit(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager', 'FreezeUnit', [DBusString(name)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.ThawUnit()
  Future<void> callThawUnit(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager', 'ThawUnit', [DBusString(name)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.ResetFailedUnit()
  Future<void> callResetFailedUnit(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'ResetFailedUnit',
        [DBusString(name)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.SetUnitProperties()
  Future<void> callSetUnitProperties(
      String name, bool runtime, List<List<DBusValue>> properties,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager',
        'SetUnitProperties',
        [
          DBusString(name),
          DBusBoolean(runtime),
          DBusArray(DBusSignature('(sv)'),
              properties.map((child) => DBusStruct(child)))
        ],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.BindMountUnit()
  Future<void> callBindMountUnit(String name, String source, String destination,
      bool read_only, bool mkdir,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager',
        'BindMountUnit',
        [
          DBusString(name),
          DBusString(source),
          DBusString(destination),
          DBusBoolean(read_only),
          DBusBoolean(mkdir)
        ],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.MountImageUnit()
  Future<void> callMountImageUnit(
      String name,
      String source,
      String destination,
      bool read_only,
      bool mkdir,
      List<List<DBusValue>> options,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager',
        'MountImageUnit',
        [
          DBusString(name),
          DBusString(source),
          DBusString(destination),
          DBusBoolean(read_only),
          DBusBoolean(mkdir),
          DBusArray(
              DBusSignature('(ss)'), options.map((child) => DBusStruct(child)))
        ],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.RefUnit()
  Future<void> callRefUnit(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager', 'RefUnit', [DBusString(name)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.UnrefUnit()
  Future<void> callUnrefUnit(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager', 'UnrefUnit', [DBusString(name)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.StartTransientUnit()
  Future<DBusObjectPath> callStartTransientUnit(String name, String mode,
      List<List<DBusValue>> properties, List<List<DBusValue>> aux,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'StartTransientUnit',
        [
          DBusString(name),
          DBusString(mode),
          DBusArray(DBusSignature('(sv)'),
              properties.map((child) => DBusStruct(child))),
          DBusArray(
              DBusSignature('(sa(sv))'), aux.map((child) => DBusStruct(child)))
        ],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetUnitProcesses()
  Future<List<List<DBusValue>>> callGetUnitProcesses(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'GetUnitProcesses', [DBusString(name)],
        replySignature: DBusSignature('a(sus)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.AttachProcessesToUnit()
  Future<void> callAttachProcessesToUnit(
      String unit_name, String subcgroup, List<int> pids,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager',
        'AttachProcessesToUnit',
        [DBusString(unit_name), DBusString(subcgroup), DBusArray.uint32(pids)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.AbandonScope()
  Future<void> callAbandonScope(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager', 'AbandonScope', [DBusString(name)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetJob()
  Future<DBusObjectPath> callGetJob(int id,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'GetJob', [DBusUint32(id)],
        replySignature: DBusSignature('o'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetJobAfter()
  Future<List<List<DBusValue>>> callGetJobAfter(int id,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'GetJobAfter', [DBusUint32(id)],
        replySignature: DBusSignature('a(usssoo)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetJobBefore()
  Future<List<List<DBusValue>>> callGetJobBefore(int id,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'GetJobBefore', [DBusUint32(id)],
        replySignature: DBusSignature('a(usssoo)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.CancelJob()
  Future<void> callCancelJob(int id,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager', 'CancelJob', [DBusUint32(id)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.ClearJobs()
  Future<void> callClearJobs(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'ClearJobs', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.ResetFailed()
  Future<void> callResetFailed(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'ResetFailed', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.SetShowStatus()
  Future<void> callSetShowStatus(String mode,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager', 'SetShowStatus', [DBusString(mode)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.ListUnits()
  Future<List<List<DBusValue>>> callListUnits(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'ListUnits', [],
        replySignature: DBusSignature('a(ssssssouso)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ListUnitsFiltered()
  Future<List<List<DBusValue>>> callListUnitsFiltered(List<String> states,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'ListUnitsFiltered', [DBusArray.string(states)],
        replySignature: DBusSignature('a(ssssssouso)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ListUnitsByPatterns()
  Future<List<List<DBusValue>>> callListUnitsByPatterns(
      List<String> states, List<String> patterns,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'ListUnitsByPatterns',
        [DBusArray.string(states), DBusArray.string(patterns)],
        replySignature: DBusSignature('a(ssssssouso)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ListUnitsByNames()
  Future<List<List<DBusValue>>> callListUnitsByNames(List<String> names,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'ListUnitsByNames', [DBusArray.string(names)],
        replySignature: DBusSignature('a(ssssssouso)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ListJobs()
  Future<List<List<DBusValue>>> callListJobs(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'ListJobs', [],
        replySignature: DBusSignature('a(usssoo)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.Subscribe()
  Future<void> callSubscribe(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'Subscribe', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.Unsubscribe()
  Future<void> callUnsubscribe(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'Unsubscribe', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.Dump()
  Future<String> callDump(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'Dump', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes org.freedesktop.systemd1.Manager.DumpByFileDescriptor()
  Future<ResourceHandle> callDumpByFileDescriptor(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'DumpByFileDescriptor', [],
        replySignature: DBusSignature('h'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asUnixFd();
  }

  /// Invokes org.freedesktop.systemd1.Manager.Reload()
  Future<void> callReload(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'Reload', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.Reexecute()
  Future<void> callReexecute(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'Reexecute', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.Exit()
  Future<void> callExit(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'Exit', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.Reboot()
  Future<void> callReboot(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'Reboot', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.PowerOff()
  Future<void> callPowerOff(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'PowerOff', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.Halt()
  Future<void> callHalt(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'Halt', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.KExec()
  Future<void> callKExec(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'KExec', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.SwitchRoot()
  Future<void> callSwitchRoot(String new_root, String init,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'SwitchRoot',
        [DBusString(new_root), DBusString(init)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.SetEnvironment()
  Future<void> callSetEnvironment(List<String> assignments,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'SetEnvironment',
        [DBusArray.string(assignments)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.UnsetEnvironment()
  Future<void> callUnsetEnvironment(List<String> names,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.systemd1.Manager', 'UnsetEnvironment',
        [DBusArray.string(names)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.UnsetAndSetEnvironment()
  Future<void> callUnsetAndSetEnvironment(
      List<String> names, List<String> assignments,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager',
        'UnsetAndSetEnvironment',
        [DBusArray.string(names), DBusArray.string(assignments)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.EnqueueMarkedJobs()
  Future<List<DBusObjectPath>> callEnqueueMarkedJobs(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'EnqueueMarkedJobs', [],
        replySignature: DBusSignature('ao'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPathArray().toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ListUnitFiles()
  Future<List<List<DBusValue>>> callListUnitFiles(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'ListUnitFiles', [],
        replySignature: DBusSignature('a(ss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ListUnitFilesByPatterns()
  Future<List<List<DBusValue>>> callListUnitFilesByPatterns(
      List<String> states, List<String> patterns,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'ListUnitFilesByPatterns',
        [DBusArray.string(states), DBusArray.string(patterns)],
        replySignature: DBusSignature('a(ss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetUnitFileState()
  Future<String> callGetUnitFileState(String file,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'GetUnitFileState', [DBusString(file)],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes org.freedesktop.systemd1.Manager.EnableUnitFiles()
  Future<List<DBusValue>> callEnableUnitFiles(
      List<String> files, bool runtime, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'EnableUnitFiles',
        [DBusArray.string(files), DBusBoolean(runtime), DBusBoolean(force)],
        replySignature: DBusSignature('ba(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.freedesktop.systemd1.Manager.DisableUnitFiles()
  Future<List<List<DBusValue>>> callDisableUnitFiles(
      List<String> files, bool runtime,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'DisableUnitFiles', [DBusArray.string(files), DBusBoolean(runtime)],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.EnableUnitFilesWithFlags()
  Future<List<DBusValue>> callEnableUnitFilesWithFlags(
      List<String> files, int flags,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'EnableUnitFilesWithFlags',
        [DBusArray.string(files), DBusUint64(flags)],
        replySignature: DBusSignature('ba(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.freedesktop.systemd1.Manager.DisableUnitFilesWithFlags()
  Future<List<List<DBusValue>>> callDisableUnitFilesWithFlags(
      List<String> files, int flags,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'DisableUnitFilesWithFlags',
        [DBusArray.string(files), DBusUint64(flags)],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.ReenableUnitFiles()
  Future<List<DBusValue>> callReenableUnitFiles(
      List<String> files, bool runtime, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'ReenableUnitFiles',
        [DBusArray.string(files), DBusBoolean(runtime), DBusBoolean(force)],
        replySignature: DBusSignature('ba(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.freedesktop.systemd1.Manager.LinkUnitFiles()
  Future<List<List<DBusValue>>> callLinkUnitFiles(
      List<String> files, bool runtime, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'LinkUnitFiles',
        [DBusArray.string(files), DBusBoolean(runtime), DBusBoolean(force)],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.PresetUnitFiles()
  Future<List<DBusValue>> callPresetUnitFiles(
      List<String> files, bool runtime, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'PresetUnitFiles',
        [DBusArray.string(files), DBusBoolean(runtime), DBusBoolean(force)],
        replySignature: DBusSignature('ba(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.freedesktop.systemd1.Manager.PresetUnitFilesWithMode()
  Future<List<DBusValue>> callPresetUnitFilesWithMode(
      List<String> files, String mode, bool runtime, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'PresetUnitFilesWithMode',
        [
          DBusArray.string(files),
          DBusString(mode),
          DBusBoolean(runtime),
          DBusBoolean(force)
        ],
        replySignature: DBusSignature('ba(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.freedesktop.systemd1.Manager.MaskUnitFiles()
  Future<List<List<DBusValue>>> callMaskUnitFiles(
      List<String> files, bool runtime, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'MaskUnitFiles',
        [DBusArray.string(files), DBusBoolean(runtime), DBusBoolean(force)],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.UnmaskUnitFiles()
  Future<List<List<DBusValue>>> callUnmaskUnitFiles(
      List<String> files, bool runtime,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'UnmaskUnitFiles', [DBusArray.string(files), DBusBoolean(runtime)],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.RevertUnitFiles()
  Future<List<List<DBusValue>>> callRevertUnitFiles(List<String> files,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'RevertUnitFiles', [DBusArray.string(files)],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.SetDefaultTarget()
  Future<List<List<DBusValue>>> callSetDefaultTarget(String name, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'SetDefaultTarget', [DBusString(name), DBusBoolean(force)],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetDefaultTarget()
  Future<String> callGetDefaultTarget(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'GetDefaultTarget', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes org.freedesktop.systemd1.Manager.PresetAllUnitFiles()
  Future<List<List<DBusValue>>> callPresetAllUnitFiles(
      String mode, bool runtime, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'PresetAllUnitFiles',
        [DBusString(mode), DBusBoolean(runtime), DBusBoolean(force)],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.AddDependencyUnitFiles()
  Future<List<List<DBusValue>>> callAddDependencyUnitFiles(
      List<String> files, String target, String type, bool runtime, bool force,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager',
        'AddDependencyUnitFiles',
        [
          DBusArray.string(files),
          DBusString(target),
          DBusString(type),
          DBusBoolean(runtime),
          DBusBoolean(force)
        ],
        replySignature: DBusSignature('a(sss)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetUnitFileLinks()
  Future<List<String>> callGetUnitFileLinks(String name, bool runtime,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'GetUnitFileLinks', [DBusString(name), DBusBoolean(runtime)],
        replySignature: DBusSignature('as'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asStringArray().toList();
  }

  /// Invokes org.freedesktop.systemd1.Manager.SetExitCode()
  Future<void> callSetExitCode(int number,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod(
        'org.freedesktop.systemd1.Manager', 'SetExitCode', [DBusByte(number)],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.systemd1.Manager.LookupDynamicUserByName()
  Future<int> callLookupDynamicUserByName(String name,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'LookupDynamicUserByName', [DBusString(name)],
        replySignature: DBusSignature('u'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asUint32();
  }

  /// Invokes org.freedesktop.systemd1.Manager.LookupDynamicUserByUID()
  Future<String> callLookupDynamicUserByUID(int uid,
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.systemd1.Manager',
        'LookupDynamicUserByUID', [DBusUint32(uid)],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes org.freedesktop.systemd1.Manager.GetDynamicUsers()
  Future<List<List<DBusValue>>> callGetDynamicUsers(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'org.freedesktop.systemd1.Manager', 'GetDynamicUsers', [],
        replySignature: DBusSignature('a(us)'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStruct())
        .toList();
  }
}
