#!/usr/bin/env bash
# Original command used to generate the systemd dbus definitions.
# See pub.dev/packages/dbus
# You need to run the bin/dart_dbus command from that package
#
# You probably don't need to rerun this again unless there are breaking changes in systemd(1)
~/dbus generate-remote-object systemd.xml -o systemd.dart
