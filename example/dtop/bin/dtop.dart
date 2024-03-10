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

    console.writeLine();

    _printProcs(stat.processes);
  }

  console.resetColorAttributes();
}

String _dfmt(double n) => n.toStringAsFixed(1);
String _dl(String label, double n) => '${_dfmt(n)}% $label, ';

var i = 0;
void _printProcs(List<Process> plist) {
  Process.sort(plist, (p) => p.cpuPercentage, false);

  for (final p in plist) {
    if (p.cpuPercentage == 0.0) continue;
    console.writeAligned(p.pid, 8);
    console.writeAligned(p.command, 30);
    console.writeAligned(_dfmt(p.cpuPercentage));
    console.writeLine();
    // if (++i > 30) break;
  }
}
