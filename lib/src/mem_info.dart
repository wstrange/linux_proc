import 'dart:io';

int totalMemoryKb = 1; // global... so we can cache this. Ugly

final whiteSplitRegEx = RegExp(r'\s+');

typedef MemInfo = ({int memTotal, int memFree, int memAvailable});

/// Gets the total system memory in kilobytes.
/// cache this so subsquent lookups are fast. Memory
///
MemInfo getMemoryInfo() {
  final meminfoFile = File('/proc/meminfo');
  if (!meminfoFile.existsSync()) {
    throw ArgumentError('Failed to read /proc/meminfo');
  }
  MemInfo m = (memTotal: 0, memAvailable: 0, memFree: 0);

  final lines = meminfoFile.readAsLinesSync();
  for (final line in lines) {
    final parts = line.split(whiteSplitRegEx);
    if (parts.length < 2) {
      continue;
    }

    final key = parts[0];
    final value = int.tryParse(parts[1]) ?? 0;

    m = switch (key) {
      'MemTotal:' => (
          memTotal: value,
          memFree: m.memFree,
          memAvailable: m.memAvailable
        ),
      'MemFree:' => (
          memTotal: m.memTotal,
          memFree: value,
          memAvailable: m.memAvailable
        ),
      'MemAvailable:' => (
          memTotal: m.memTotal,
          memFree: m.memFree,
          memAvailable: value
        ),
      _ => m
    };
  }
  return m;
}
