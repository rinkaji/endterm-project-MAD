import 'package:myapp/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  //db constants
  static const String dbName = "attendance.db";
  static const int dbVersion = 3;

  //table constants

  //group table
  static const String groupTb = "groups";
  static const String groupColId = 'group_id';
  static const String groupColName = 'group_name';
  static const String groupColTheme = 'group_theme';
  static const String groupColSubj = 'group_subj';
  static const String groupColSubSection = 'group_subsection';

  // members table
  static const String memberTb = "members";
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

  //events table
  static const String eventTb = "event";
  static const String eventColId = "event_id";
  static const String eventColName = "event_name";
  static const String eventColDate = "event_date";
  static const String eventColGroupId = "event_group_id";

  // //events_in_group table
  // static const String eventGroupTb = "event_group";
  // static const String eventGroupColId = "event_group_id";
  // static const String eventGroupColGroupId = "group_id";
  // static const String eventGroupColEventId = "event_id";

  static Future<Database> openDb() async {
    var path = join(await getDatabasesPath(), dbName);
    var createGroupTb = '''CREATE TABLE IF NOT EXISTS $groupTb (
      $groupColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $groupColName VARCHAR(200) NOT NULL,
      $groupColTheme VARCHAR(200),
      $groupColSubj TEXT,
      $groupColSubSection TEXT
    );''';
    var createMemberTb = '''CREATE TABLE IF NOT EXISTS $memberTb (
      $memberColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $memberColName VARCHAR(200),
      $memberColGroupId INTEGER,
      FOREIGN KEY ($memberColGroupId) REFERENCES $groupTb ($groupColId) ON DELETE CASCADE ON UPDATE CASCADE
    );''';
    var createAttendanceTb = '''CREATE TABLE IF NOT EXISTS $attendanceTb (
      $attendanceColMemberId INTEGER, 
      $attendanceColGroupId INTEGER, 
      $attendanceDate TEXT,
      $attendanceStatus TEXT,
      PRIMARY KEY($attendanceColGroupId, $attendanceColMemberId),
      FOREIGN KEY ($attendanceColMemberId) REFERENCES $memberTb ($memberColId) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY ($attendanceColGroupId) REFERENCES $groupTb ($groupColId) ON DELETE CASCADE ON UPDATE CASCADE
    );''';

    var createEventTb = '''CREATE TABLE IF NOT EXISTS $eventTb(
    $eventColId INTEGER PRIMARY KEY AUTOINCREMENT,
    $eventColName VARCHAR(200),
    $eventColDate VARCHAR(200),
    $eventColGroupId INTEGER,
    FOREIGN KEY ($eventColGroupId) REFERENCES $groupTb ($groupColId) ON DELETE CASCADE ON UPDATE CASCADE
    );''';

    // var createEventGroupTb = '''CREATE TABLE IF NOT EXISTS $eventGroupTb(
    // $eventGroupColId INTEGER PRIMARY KEY AUTOINCREMENT,
    // $eventGroupColGroupId INT,
    // $eventGroupColEventId INT
    // );''';
    var db = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) {
        db.execute(createGroupTb);
        print("$groupTb created");
        db.execute(createMemberTb);
        print("$memberTb created");
        db.execute(createAttendanceTb);
        print("$attendanceTb created");
        db.execute(createEventTb);
        print("$eventTb created");
        // db.execute(createEventGroupTb);
        // print("$eventGroupTb created");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion <= oldVersion) return;
        db.execute("DROP TABLE IF EXISTS $groupTb");
        db.execute(createGroupTb);
        db.execute("DROP TABLE IF EXISTS $memberTb");
        db.execute(createMemberTb);
        db.execute("DROP TABLE IF EXISTS $attendanceTb");
        db.execute(createAttendanceTb);
        db.execute("DROP TABLE IF EXISTS $eventTb");
        db.execute(createEventTb);
        // db.execute("DROP TABLE IF EXISTS $eventGroupTb");
        // db.execute(createEventGroupTb);
        print("dropped and new table created");
      },
    );
    print("database opened");
    return db;
  }

  static Future<int> createGroup(Category category) async {
    var db = await openDb();
    var id = await db.insert(groupTb, category.toMapWithoutId());
    print('${id} group added');
    return id;
  }

  static Future<List<Map<String, dynamic>>> fetchGroup() async {
    final db = await openDb();
    var result = await db.query(groupTb);
    print('${result} group fetched');
    return result;
  }

  static Future<int> updateGroup(Category category) async {
    final db = await openDb();
    var result = await db.update(groupTb, category.toMap(),
        where: "$groupColId = ?", whereArgs: [category.id]);
    print('${result} group fetched');
    return result;
  }

  static void deleteGroup(Category category) async {
    final db = await openDb();
    await db
        .delete(groupTb, where: "$groupColId = ?", whereArgs: [category.id]);
  }

  static Future<int> addMember(Participant participant) async {
    var db = await DbHelper.openDb();
    int id = await db.insert(memberTb, participant.toMapWithoutId());
    print('${id} member added');
    return id;
  }

  static Future<List<Map<String, dynamic>>> fetchMember(int id) async {
    var db = await DbHelper.openDb();
    var result = await db.query(memberTb,
        columns: [
          DbHelper.memberColId,
          DbHelper.memberColGroupId,
          DbHelper.memberColName
        ],
        where: '${DbHelper.memberColGroupId} = ?',
        whereArgs: [id]);
    print('${result} member fetched');
    return result;
  }

  static Future<int> updateMember(Participant participant) async {
    var db = await DbHelper.openDb();
    int result = await db.update(memberTb, participant.toMap(),
        where: '${DbHelper.memberColId} = ?', whereArgs: [participant.ptID]);
    print('${result} member updated');
    return result;
  }

  static Future<int> deleteMember(int id) async {
    var db = await DbHelper.openDb();
    int result = await db.delete(memberTb,
        where: '${DbHelper.memberColId} = ?', whereArgs: [id]);
    deleteAttendance(id);
    print('${result} member updated');
    return id;
  }

  //for event table queries
  static Future<int> addEvent(Event event) async {
    var db = await DbHelper.openDb();
    int id = await db.insert(eventTb, event.toMapWithoutId());
    print("last inserted $id");
    return id;
  }

  static Future<List<Map<String, Object?>>> fetchEvent(int groupId) async {
    var db = await DbHelper.openDb();
    var result = await db.query(eventTb,
        columns: [eventColId, eventColName, eventColDate, eventColGroupId],
        where: "${eventColGroupId} = ?",
        whereArgs: [groupId]);
    print("${result} member fetched");
    return result;
  }

  static void deleteEvent(int id) async {
    var db = await DbHelper.openDb();
    await db
        .delete(eventTb, where: '${DbHelper.eventColId} = ?', whereArgs: [id]);
  }

  static void updateEvent(Event event) async {
    var db = await DbHelper.openDb();
    await db.update(eventTb, event.toMap(),
        where: "$eventColId = ?", whereArgs: [event.id]);
  }

  //for attendance table queries
  static Future<int> addAttendance(Attendance attendance) async {
    var db = await DbHelper.openDb();
    int id = await db.insert(attendanceTb, attendance.toMapWithoutId(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("$id added");
    return id;
  }

  static Future<List<Map>> fetchAttendance(String month, String? status, int ptId, int catId) async {
    var db = await DbHelper.openDb();

    var results = await db.query(attendanceTb,
        columns: [
          DbHelper.attendanceColGroupId,
          attendanceDate,
          attendanceStatus
        ],
        where: '$attendanceDate LIKE ? AND $attendanceStatus = ? AND $attendanceColMemberId = ? AND $attendanceColGroupId = ?',
        whereArgs: ['$month', '$status', '$ptId', '$catId'],
        orderBy: attendanceDate);
    print("${results} attendance record fetched for ${month}");
    return results;
  }

  static void deleteAttendance(int memberId) async {
    var db = await DbHelper.openDb();
    await db.delete(attendanceTb,
        where: '$attendanceColMemberId = ?', whereArgs: [memberId]);
  }
  
}
