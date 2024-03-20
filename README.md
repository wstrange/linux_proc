# linux_proc: Linux process utilities

A Dart package to read Linux process status and DBus services.


## Features

* Parses the procfs(5) /proc filesystem for Linux process information
* Parses the output of systemd DBus queries for Systemd service status (WIP)


## Sample Dart Top

See [dtop](example/dtop/bin/dtop.dart) for an example of how to use this package to implement a Dart version of top(1).


```dart
cd example/dtop
dart pub get
dart run bin/dtop.dart

````