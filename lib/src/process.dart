import 'dart:io';

final procDir = Directory('/proc');

typedef ProcMap = Map<String, dynamic>;

Future<Map<int, ProcMap>> getProcessInfo() async {
  var m = <int, ProcMap>{};

  await for (var d in procDir.list()) {
    var proc = d.path.split('/').last;
    var pid = int.tryParse(proc);
    if (pid != null) {
      var s = await parseProcStat(pid);
      if (s.isNotEmpty) m[pid] = s;
    }
  }
  return m;
}

Future<ProcMap> parseProcStat(int pid) async {
  final filePath = File('/proc/$pid/stat');

  try {
    // its possible that the process could now be gone by the time
    // we try to stat it, so check and return an empty map if that is the case
    if (!await filePath.exists()) {
      return {};
    }

    final lines = await filePath.readAsLines();

    if (lines.isEmpty) {
      return {};
    }

    final statLine = lines.first;
    // note the command can be of the form '(tmux: client)' i.e. could
    // have a space. we
    final values = statLine.split(' ').toList();

    int i = 0;

    // todo: Could make this dynamic to return an int, Bigint, or strings..
    String nextVal() {
      var v = values[i++];
      if (!v.startsWith('(')) return v;
      // start of ( - need to greedily read until we see the )
      while (!v.endsWith(')')) {
        v = v + nextVal();
      }
      return v.substring(1, v.length - 1);
    }

    int? nextInt() => int.tryParse(nextVal());

    // Reference: https://man7.org/linux/man-pages/man5/proc.5.html#proc_pid_stat
    return {
      'pid': nextInt(),
      'cmd': nextVal(),
      'state': nextVal(),
      'ppid': nextInt(),
      'pgrp': nextInt(),
      'session': nextInt(),
      'tty_nr': nextInt(),
      'tpgid': nextInt(),
      'flags': nextInt(),
      'minflt': nextInt(),
      'majflt': nextInt(),
      'utime': nextInt(),
      'stime': nextInt(),
      'cutime': nextInt(),
      'cstime': nextInt(),
      'priority': nextInt(),
      'nice': nextInt(),
      'num_threads': nextInt(),
      'itrealvalue': nextInt(),
      'starttime': nextInt(),
      'vsize': nextInt(),
      'rss': nextInt(),
      'rsslim': nextInt(),
      // these are large - need to be bigint or a string..
      'startcode': nextVal(),
      'endcode': nextVal(),
      'startstack': nextVal(),
      'kstespts': nextVal(),
      'kstackesp': nextVal(),
      'kstkeip': nextVal(),
      'signal': nextInt(),
      'blocked': nextInt(),
      'sigignore': nextInt(),
      'sigcatch': nextInt(),
      'wchan': nextInt(),
      'nswap': nextVal(),
      'cnswap': nextVal(),
      'exit_signal': nextInt(),
      'processor': nextInt(),
      'rt_priority': nextInt(),
      'policy': nextInt(),
      'delayacct_blkio_ticks': nextInt(),
      'guest_time': nextInt(),
      'cguest_time': nextInt(),
      'start_time': nextInt(),
      'vruntime': nextInt(),
      // ... further process fields if needed
    };
  } catch (error) {
    print('Error parsing $filePath: $error');
    rethrow; // Rethrow the error for proper handling
  }
}

// A nicer representation of a process
class Process {
  final ProcMap procMap; // the raw process attributes

  // some convenience getters
  int get pid => procMap['pid'];
  String get command => procMap['cmd'];
  int get userTime => procMap['utime'];
  int get systemTime => procMap['stime'];

  Process(this.procMap);

  static Future<Process?> getProcess(int pid) async {
    var procMap = await parseProcStat(pid);
    return procMap.isEmpty ? null : Process(procMap);
  }

  static Future<List<Process>> getAllProcesses() async {
    var l = <Process>[];

    var plist = await getProcessInfo();
    for (var info in plist.values) {
      l.add(Process(info));
    }
    return l;
  }
}
