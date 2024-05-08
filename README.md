# linux_proc: Linux process utilities

A Dart package to read Linux system statistics, process status and DBus services.

DBus is still very much a work in progress.

**Note this library only supports Linux**

## Features

* Parses the procfs(5) /proc filesystem for Linux system and process information
* Parses the output of systemd DBus queries for Systemd service status (WIP)


## Using the API

```dart
  // create a stats manager
  final statsManager = StatsManager(refreshTimeSeconds: 2, queueSize: 100);

  // get the stream of statistics.
  await for (final stat in statsManager.stream) {
    // stat  ref contains cpus stats, process info, etc.
  }

  // To pause stats collection
  statsManager.setRefreshTime(0);

  // to start it again
  statsManager.setRefreshSeconds(4);

  // get the queue of the last N results
  var q = statsManager.statsQueue;

```

## Dart Top

See [dtop](github.com/wstrange/linux_proc/dtop) for an example of how to use this package to implement a Dart version of the Linux top(1) command.


```dart
cd dtop
dart pub get
dart run bin/dtop.dart
````

![dtop gif](https://github.com/wstrange/linux_proc/dtop.gif)

## Performance

This library uses the synchronous versions of most `dart:io` file system calls to parse the procfs filesystem.

The overhead is much lower using synchronous calls. For example, using async i/o, the `dtop` command consumes approx. 8% of a virtual CPU when the statistics are refreshed every 2 seconds.  Using Synchronous i/o brings this down to approx. 3%.

If you are going to use this library in a Flutter application, you may need to run  the statistics gathering in an isolate to avoid blocking the UI thread.


