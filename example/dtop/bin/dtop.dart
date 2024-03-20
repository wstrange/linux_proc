import 'package:linux_proc/linux_proc.dart';
import 'package:dart_console2/dart_console2.dart';

final console = Console();

void main(List<String> arguments) async {
  final statsStream = StatsManager(refreshTimeSeconds: 2);

  console.clearScreen();

  await for (final stat in statsStream.stream) {
    var s = stat.stats;
    console.resetCursorPosition();

    console.writeLine(
        'CPU Usage: ${_dl('user', s.userTimePercentage)}${_dl('sys', s.systemTimePercentage)}${_dl('idle', s.idleTimePercentage)}');

    final memInfo = stat.memInfo;
    console.writeLine(
        'Memory: ${memInfo.memTotal} free: ${memInfo.memFree} available: ${memInfo.memAvailable} Tasks: ${stat.processes.length} running: ${s.procsRunning} blocked ${s.procsBlocked}');

    console.setBackgroundColor(ConsoleColor.white);
    console.setForegroundColor(ConsoleColor.black);
    console.writeLine('     PID USER       %CPU    Virt   RSS  %MEM COMMAND');
    console.resetColorAttributes();

    _printProcs(stat.processes, memInfo);
  }

  console.resetColorAttributes();
}

String _dfmt(double n) => n.toStringAsFixed(1);
String _dl(String label, double n) => '${_dfmt(n)}% $label, ';
String _memoryFmt(int kb) => '${(kb / 1000000.0).toStringAsFixed(1)}g';

void _printProcs(List<Process> plist, MemInfo m) {
  Process.sort(plist, (p) => p.cpuPercentage, false);

  var i = 0;

  for (final p in plist) {
    // dont make window scroll
    if (i++ > (console.windowHeight - 5)) break;

    console.writeAligned(p.procPid, 8, TextAlignment.right);
    console.writeAligned(' ${p.userName}', 12);
    console.writeAligned(_dfmt(p.cpuPercentage), 4, TextAlignment.right);
    console.writeAligned(_memoryFmt(p.vmSize), 8, TextAlignment.right);
    console.writeAligned(_memoryFmt(p.rss), 7, TextAlignment.right);

    console.writeAligned(
        _dfmt(p.memoryPercentage(m.memTotal)), 5, TextAlignment.right);
    console.writeAligned(' ${p.command}', 30);

    console.writeLine();
  }
}
