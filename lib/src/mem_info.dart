import 'dart:io';

int totalMemoryKb = 1; // global... so we can cache this. Ugly

final whiteSplitRegEx = RegExp(r'\s+');

/// Gets the total system memory in kilobytes.
/// cache this so subsquent lookups are fast. Memory
///
Future<int> getTotalMemory() async {
  final meminfoFile = File('/proc/meminfo');
  if (!await meminfoFile.exists()) {
    throw ArgumentError('Failed to read /proc/meminfo');
  }

  final lines = await meminfoFile.readAsLines();
  for (final line in lines) {
    final parts = line.split(whiteSplitRegEx);
    if (parts.length < 2) {
      continue;
    }

    final key = parts[0];
    final value = parts[1];
    if (key == 'MemTotal:') {
      totalMemoryKb = int.parse(value);
    }

    return totalMemoryKb;
  }

  throw ArgumentError('Failed to find MemTotal in /proc/meminfo');
}
