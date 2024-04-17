import 'dart:io';

import 'passwd.dart';

/// Linux Process Utilities
/// See https://www.kernel.org/doc/html/latest/filesystems/proc.html
///
/// The gist is that under /proc/{pid} you have a number of virtual
/// files that describe the process.
/// You need to read from both the `status` and `stat` files to get
/// a complete picture of the process.
///
///

final _procDir = Directory('/proc');

// A map where the key is the attribute name (cmd, pid, etc) and
// the value is either a String or a number
typedef ProcMap = Map<String, dynamic>;

/// Get a list of all running process id's
///
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
Future<ProcMap> _parseProcStat(int pid) async {
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
      'sid': nextInt(),
      'tty_nr': nextInt(),
      'tty_pgrp': nextInt(),
      'flags': nextInt(),
      'min_flt': nextInt(),
      'cmin_flt': nextInt(),
      'maj_flt': nextInt(),
      'cmaj_flt': nextInt(),
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

final _whiteSpaceRegEx = RegExp(r'\s+');

/// Parses /proc/$pid/status

Future<ProcMap> _parseProcStatus(int pid) async {
  final filePath = '/proc/$pid/status';
  final file = File(filePath);

  if (!await file.exists()) {
    return {};
  }

  final lines = await file.readAsLines();
  ProcMap values = {};

  for (final line in lines) {
    final parts = line.split(_whiteSpaceRegEx);
    // trim the :
    final key = parts[0].substring(0, parts[0].length - 1);
    final value = parts[1];

    // special value handling...
    // generally id's are single value ints,
    // but UID / GID containt  the real,effective,saved set,filesystem ids
    // Right now we only care about the real and effective uid

    // uid / gid have 4 int values on the same line. Grab the first two
    if (key == 'Uid' || key == 'Gid') {
      values[key] = int.tryParse(value);
      values['$key.effective'] = int.tryParse(parts[2]);
    } else {
      values[key] = int.tryParse(value) ?? value;
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
  int get procPid => procMap['pid'];
  String get command => procMap['cmd'];
  int get userTime => procMap['utime'];
  int get systemTime => procMap['stime'];
  String get state => procMap['state'];
  int get uid => procMap['Uid'];
  String get userName => passwd.userName;
  int get totalCPU => userTime + systemTime;
  // resident set size
  int get rss => procMap['VmRSS'] ?? procMap['rss'] ?? 0;
  // vmSize..
  int get vmSize => procMap['VmSize'] ?? 0;

  // calculate memory percentage of the RSS relative to the supplied total
  double memoryPercentage(int totalMemory) =>
      (rss * 100.0) / totalMemory.toDouble();

  // Calculate the percentage of CPU this process is consuming.
  // The side effect sets the [cpuPercentage] value so we
  // can sort on it later.
  // [prev] is the previous cpu times for this pid
  // [intervalSeconds] is the time between samples
  void updateCPUPercentage(Process prev, double intervalSeconds) {
    if (procPid != prev.procPid) {
      throw 'The previous process pid is not the same.';
    }

    cpuPercentage = (totalCPU - prev.totalCPU).toDouble() / intervalSeconds;
  }

  /// Time the process started after system boot
  int get startTime => procMap['start_time'];

  Process(
    this.procMap,
    this.passwd,
  );

  static Future<Process?> getProcess(int pid) async {
    var procMap = await _parseProcStat(pid);
    var procStatusMap = await _parseProcStatus(pid);
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

    return other.procPid == procPid;
  }

  @override
  int get hashCode => procPid.hashCode;

  /// Given a list of processes [l], sort by field [getField] in
  /// [asc] ascending/decending order
  ///
  /// For example, (cpu, created, etc)
  ///  Process.sort(myProcs, (p) => p.cpuPercentage, true)
  /// Note the list is sorted in place. The same list is returned.
  static List<Process> sort(List<Process> l, ProcessField getField, bool asc) {
    l.sort((a, b) => asc
        ? getField(a).compareTo(getField(b))
        : getField(b).compareTo(getField(a)));
    return l;
  }
}

/// Typedef to represent a field getter on a Process object.
/// This is used by [Process.sort]
typedef ProcessField = Comparable Function(Process p);
