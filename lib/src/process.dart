import 'dart:io';

import 'passwd.dart';

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

Future<List<int>> getAllPids() async {
  var l = <int>[];

  await for (final d in _procDir.list()) {
    var proc = d.path.split('/').last;
    var pid = int.tryParse(proc);
    // pid above might not be a number (/proc contains other things)
    // skip if not a process
    if (pid != null) {
      l.add(pid);
    }
  }
  return l;
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
    return {};
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

/// A nicer representation of a process
///
/// Note that "Time" values are Jiffies. This is the
/// number of ticks of the system clock since the process was started.
///
/// On most systems you can get the clock rate (HZ) by running:
/// `getconf CLK_TCK`.
/// Typically 100 Hz
///
class Process {
  final ProcMap procMap; // the raw process attributes
  final Passwd passwd; // the associated password entry. Used to map user ids

  // the percentage of CPU this process is consuming.
  // To calculate this we need access to the previous value
  // see [calculateCPUPercentage]
  double cpuPercentage = 0.0;

  // some convenience getters
  int get pid => procMap['pid'];
  String get command => procMap['cmd'];
  int get userTime => procMap['utime'];
  int get systemTime => procMap['stime'];
  String get state => procMap['state'];
  int get uid => procMap['Uid'];
  String get userName => passwd.userName;
  int get totalCPU => userTime + systemTime;

  // Calculate the percentage of CPU this process is consuming.
  // As a side effect we set the [cpuPercentage] value so we
  // can sort on it later.
  // [prev] is the previous cpu times for this pid
  // [systemCPUJiffies] is the total cpu time (user+sys) for all
  // processes
  double calculateCPUPercentage(Process prev, int deltaSystemCPU) {
    if (pid != prev.pid) {
      throw 'The previous process pid is not the same.';
    }
    final deltaCPU = totalCPU - prev.totalCPU;
    cpuPercentage = (deltaCPU * 100.0) / deltaSystemCPU;
    return cpuPercentage;
  }

  /// Time the process started after system boot
  int get startTime => procMap['start_time'];

  Process(
    this.procMap,
    this.passwd,
  );

  static Future<Process?> getProcess(int pid) async {
    var procMap = await parseProcStat(pid);
    var procStatusMap = await parseProcStatus(pid);
    // based on timing, the process might have gone away,
    // so don't add it.
    if (procMap.isEmpty || procStatusMap.isEmpty) {
      return null;
    }
    var pw = await Passwd.getPasswdEntry(procStatusMap['Uid']);
    procMap.addAll(procStatusMap);
    return procMap.isEmpty ? null : Process(procMap, pw!);
  }

  /// Get a map of all running process keyed by pid
  ///
  static Future<Map<int, Process>> getAllProcesses() async {
    var pids = await getAllPids();

    final m = <int, Process>{};

    for (final pid in pids) {
      var p = await getProcess(pid);
      if (p != null) {
        m[pid] = p;
      }
    }
    return m;
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

  /// Given a list of processes, sort by field (cpu, created, etc)
  static void sort(List<Process> l, ProcField getField, bool asc) {
    l.sort((a, b) => asc
        ? getField(a).compareTo(getField(b))
        : getField(b).compareTo(getField(a)));
  }
}

typedef ProcField = Comparable Function(Process p);
