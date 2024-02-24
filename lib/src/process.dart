import 'dart:io';

/// Linux Process Utilities
/// See https://www.kernel.org/doc/html/latest/filesystems/proc.html
///
/// The gist is that under /proc/{pid} you have a number of virtual
/// files that describe the process.
/// You need to read from both the `status` and `stat` files to get
/// relatively complete picture of the process.
///
///

final _procDir = Directory('/proc');

// A map where the key is the attribute name (cmd, pid, etc) and
// the value is either a String or a number
typedef ProcMap = Map<String, dynamic>;

Future<Map<int, ProcMap>> getProcessInfo() async {
  var m = <int, ProcMap>{};

  await for (var d in _procDir.list()) {
    var proc = d.path.split('/').last;
    var pid = int.tryParse(proc);
    // pid above might not be a number (/proc contains other things)
    // skip if not a process
    if (pid != null) {
      var s = await parseProcStat(pid);
      if (s.isNotEmpty) m[pid] = s;
    }
  }
  return m;
}

/// Parses /proc/$pid/stat
///
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

/// Parses /proc/$pid/status

Future<ProcMap> parseProcStatus(int pid) async {
  final filePath = '/proc/$pid/status';
  final file = File(filePath);

  if (!await file.exists()) {
    throw Exception('Process with pid $pid not found');
  }

  final lines = await file.readAsLines();
  ProcMap values = {};

  for (final line in lines) {
    final parts = line.split(':');
    if (parts.length == 2) {
      final key = parts[0].trim();
      final value = parts[1].trim();
      // special value handling...
      // generally id's are single value ints,
      // but UID / GID containt  the real,effective,saved set,filesystem ids
      // Right now we only care about the real and effective uid

      if (key == 'Uid' || key == 'Gid') {
        var vals = value.split('\t');
        values[key] = int.tryParse(vals[0]);
        values['$key.effective'] = int.tryParse(vals[1]);
      } else if (key.endsWith('id')) {
        values[key] = int.tryParse(value);
      } else {
        values[key] = value;
      }
    }
  }

  return values;
}

// A nicer representation of a process
class Process {
  final ProcMap procMap; // the raw process attributes

  // some convenience getters
  int get pid => procMap['pid'];
  String get command => procMap['cmd'];
  int get userTime => procMap['utime'];
  int get systemTime => procMap['stime'];
  String get state => procMap['state'];
  int get uid => procMap['Uid'];

  Process(
    this.procMap,
  );

  static Future<Process?> getProcess(int pid) async {
    var procMap = await parseProcStat(pid);
    var procStatusMap = await parseProcStatus(pid);
    procMap.addAll(procStatusMap);
    return procMap.isEmpty ? null : Process(procMap);
  }

  static Future<List<Process>> getAllProcesses() async {
    List<Process> l = [];
    var plist = await getProcessInfo();
    for (var info in plist.values) {
      l.add(Process(info));
    }
    print('Got ${l.length} proceses');
    return l;
  }

  @override
  String toString() => 'Process(procMap: $procMap)';

  // processes are the same of they have the same pid
  @override
  bool operator ==(covariant Process other) {
    if (identical(this, other)) return true;

    return other.pid == pid;
  }

  @override
  int get hashCode => pid.hashCode;

  static void sort(List<Process> l, ProcField getField, bool asc) {
    l.sort((a, b) => asc
        ? getField(a).compareTo(getField(b))
        : getField(b).compareTo(getField(a)));
  }

  // static sortByCmd(List<Process> l) {
  //   l.sort( (a,b) => a.)
  // }
}

typedef ProcField = Comparable Function(Process p);

// class ProcessSet {
//   Set<Process> processSet;

//   ProcessSet(this.processSet);

//   static Future<ProcessSet> getProcesses() async {
//     var p = await Process.getAllProcesses();
//     p.sort();
//     return ProcessSet(p);
//   }
// }
