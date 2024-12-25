import 'package:myapp/model/model.dart';

class Attendance {
  int? attendanceId;
  late int memberId;
  late int groupId;
  late String attendanceDate;
  late String attendanceStatus;

  Attendance({this.attendanceId, required this.memberId, required this.groupId, required this.attendanceDate, required this.attendanceStatus});
}

List<Map<String, dynamic>> attendance = [
  {
    'attendance_id': 0,
    'member_id': 0,
    'group_id': 0,
    'attendance_date': '2024-12-27',
    'attendance_status': 'Present'
  },
  {
    'attendance_id': 1,
    'member_id': 0,
    'group_id': 0,
    'attendance_date': '2024-12-28',
    'attendance_status': 'Present'
  },
  {
    'attendance_id': 2,
    'member_id': 0,
    'group_id': 0,
    'attendance_date': '2024-12-29',
    'attendance_status': 'Present'
  },
  {
    'attendance_id': 3,
    'member_id': 0,
    'group_id': 0,
    'attendance_date': '2024-12-31',
    'attendance_status': 'Present'
  },
  {
    'attendance_id': 4,
    'member_id': 0,
    'group_id': 0,
    'attendance_date': '2024-12-30',
    'attendance_status': 'Present'
  },
];
