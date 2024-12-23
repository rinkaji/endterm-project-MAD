import 'package:myapp/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  //db constants
  static const String dbName = "attendance.db";
  static const int dbVersion = 1;

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

  //events_in_group table
  static const String eventGroupTb = "event_group";
  static const String eventGroupColId = "event_group_id";
  static const String eventGroupColGroupId = "group_id";
  static const String eventGroupColEventId = "event_id";
  

  //events table 
  static const String eventTb = "event";
  static const String eventColId = "event_id";
  static const String eventColName = "event_name";
  static const String eventColDate = "event_date";

  //events_in_group table
  static const String eventGroupTb = "event_group";
  static const String eventGroupColId = "event_group_id";
  static const String eventGroupColGroupId = "group_id";
  static const String eventGroupColEventId = "event_id";
  

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
      $attendanceColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $attendanceColMemberId INTEGER, 
      $attendanceColGroupId INTEGER, 
      $attendanceDate TEXT,
      $attendanceStatus TEXT,
      FOREIGN KEY ($attendanceColMemberId) REFERENCES $memberTb ($memberColId) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY ($attendanceColGroupId) REFERENCES $groupTb ($groupColId) ON DELETE CASCADE ON UPDATE CASCADE
    );''';
    var createEventTb = '''CREATE TABLE IF NOT EXISTS $eventTb(
    $eventColId INTEGER PRIMARY KEY AUTOINCREMENT,
    $eventColName VARCHAR(200),
    $eventColDate VARCHAR(200)
    );''';
    var createEventGroupTb = '''CREATE TABLE IF NOT EXISTS $eventGroupTb(
    $eventGroupColId INTEGER PRIMARY KEY AUTOINCREMENT,
    $eventGroupColGroupId INT,
    $eventGroupColEventId INT
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
        db.execute(createEventTb);
        print("$eventTb created");
        db.execute(createEventGroupTb);
        print("$eventGroupTb created");
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
        db.execute("DROP TABLE IF EXISTS $eventGroupTb");
        db.execute(createEventGroupTb);
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
  
  static Future<List<Category>> fetchGroup() async {
    final db = await openDb();
    final result = await db.query(groupTb);
    print('${result} group fetched');
    return result.map((map) => Category.fromMap(map)).toList();
  }
}
