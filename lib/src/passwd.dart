// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

/// represents an /etc/passwd password entry
class Passwd {
  final String userName;
  final int uid;
  final int primaryGid;
  final String fullName;
  final String homeDirPath;
  final String shell;
  Passwd({
    required this.userName,
    required this.uid,
    required this.primaryGid,
    required this.fullName,
    required this.homeDirPath,
    required this.shell,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'uid': uid,
      'primaryGid': primaryGid,
      'fullName': fullName,
      'homeDirPath': homeDirPath,
      'shell': shell,
    };
  }

  factory Passwd.fromMap(Map<String, dynamic> map) {
    return Passwd(
      userName: map['userName'] as String,
      uid: map['uid'] as int,
      primaryGid: map['primaryGid'] as int,
      fullName: map['fullName'] as String,
      homeDirPath: map['homeDirPath'] as String,
      shell: map['shell'] as String,
    );
  }
  @override
  String toString() {
    return 'Passwd(userName: $userName, uid: $uid, primaryGid: $primaryGid, fullName: $fullName, homeDirPath: $homeDirPath, shell: $shell)';
  }

  @override
  bool operator ==(covariant Passwd other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.uid == uid &&
        other.primaryGid == primaryGid &&
        other.fullName == fullName &&
        other.homeDirPath == homeDirPath &&
        other.shell == shell;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        uid.hashCode ^
        primaryGid.hashCode ^
        fullName.hashCode ^
        homeDirPath.hashCode ^
        shell.hashCode;
  }

  static final Map<int, Passwd> _passwdMapCache = {};

  ///
  /// returns a [Passwd] for the uid, or null if no entry exists
  /// The passwd map is cached in memory. Call getPasswdMap() to
  /// refresh the entries.
  static Future<Passwd?> getPasswdEntry(int uid) async {
    if (_passwdMapCache.isEmpty) {
      _passwdMapCache.addAll(await getPasswdMap());
    }
    return _passwdMapCache[uid];
  }

  /// Return a Map of /etc/passwd entries. The map key is a uid,
  /// the value is a [Passwd].
  /// The /etc/passwd file is re-read every time this is called.
  static Future<Map<int, Passwd>> getPasswdMap() async {
    final m = <int, Passwd>{};

    final lines = await File('/etc/passwd').readAsLines();
    for (final line in lines) {
      final v = line.split(':');
      int uid = int.parse(v[2]);
      m[uid] = Passwd(
          userName: v[0],
          uid: uid,
          primaryGid: int.parse(v[3]),
          fullName: v[4],
          homeDirPath: v[5],
          shell: v[6]);
    }
    // force a refresh of our map
    _passwdMapCache.clear();
    _passwdMapCache.addAll(m);
    return _passwdMapCache;
  }
}
