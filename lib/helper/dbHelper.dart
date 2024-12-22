import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  //db constants
  static const String dbName = "attendance.db";
  static const int dbVersion = 4;

  //table constants

  //group table
  static const String groupTb = "groups";
  static const String groupColId = 'group_id';
  static const String groupColName = 'group_name';
  static const String groupColTheme = 'group_theme';

  // members table
  static const String memberTb = "member";
  static const String memberColId = 'member_id';
  static const String memberColName = "member_name";
  static const String memberColGroupId = "group_id";

  // attendance table
  static const String attendanceTb = "attendance";
  static const String attendanceColId = "attendance_id";
  static const String attendanceColMemberId = "attendance_member_id";
  static const String attendanceColGroupId = "attendance_group_id";
  static const String attendanceDate = "attendance_date";
  static const String attendanceStatus = "attendance_status";

  static void openDb() async {
    var path = join(await getDatabasesPath(), dbName);
    var createGroupTb = '''CREATE TABLE IF NOT EXISTS $groupTb (
      $groupColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $groupColName VARCHAR(200)
      $groupColTheme VARCHAR(200)
    );''';
    var createMemberTb = '''CREATE TABLE IF NOT EXISTS $memberTb (
      $memberColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $memberColName VARCHAR(200),
      $memberColGroupId INTEGER,
      FOREIGN KEY ($memberColGroupId) REFERENCES $groupTb ($groupColId) ON DELETE CASCADE ON UPDATE CASCADE
    );''';
    var createAttendanceTb = '''CREATE TABLE IF NOT EXISTS $attendanceTb (
      $attendanceColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $attendanceColMemberId INTEGER, 
      $attendanceColGroupId INTEGER, 
      $attendanceDate TEXT,
      $attendanceStatus TEXT,
      FOREIGN KEY ($attendanceColMemberId) REFERENCES $memberTb ($memberColId) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY ($attendanceColGroupId) REFERENCES $groupTb ($groupColId) ON DELETE CASCADE ON UPDATE CASCADE
    );''';
    openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) {
        db.execute(createGroupTb);
        print("$groupTb created");
        db.execute(createMemberTb);
        print("$memberTb created");
        db.execute(createAttendanceTb);
        print("$attendanceTb created");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if(newVersion <= oldVersion) return;
        db.execute("DROP TABLE IF EXISTS $groupTb");
        db.execute(createGroupTb);
        db.execute("DROP TABLE IF EXISTS $memberTb");
        db.execute(createMemberTb);
        db.execute("DROP TABLE IF EXISTS $attendanceTb");
        db.execute(createAttendanceTb);
        print("dropped and new table created");
      },
    );
    print("database opened");
  }
}
