import 'package:flutter/material.dart';

import 'package:myapp/helper/dbHelper.dart';
import 'package:myapp/model/theme_selection.dart';

class Participant {
  int? ptID;
  late int catID;
  late String name;

  Participant({this.ptID, required this.catID, required this.name});

  Participant.withoutId({this.ptID, required this.catID, required this.name});

  Map<String, dynamic> toMap() {
    return {
      DbHelper.memberColId: ptID,
      DbHelper.memberColGroupId: catID,
      DbHelper.memberColName: name,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      DbHelper.memberColGroupId: catID,
      DbHelper.memberColName: name,
    };
  }

  // factory Participant.fromMap(Map<String, dynamic> map) {
  //   return Participant(
  //     ptID: map['member_id'],
  //     catID: catID, 
  //     name: name
  //   );
  // }
}

class Category {
  late int id;
  late String name;
  late ThemeSelection theme;
  String? subject;
  String? subSection;
  Category(
      {required this.id,
      required this.name,
      required this.theme,
      this.subject,
      this.subSection});

  Category.withoutId(
      {required this.name, required this.theme, this.subject, this.subSection});

  Map<String, dynamic> toMap() {
    return {
      DbHelper.groupColId: id,
      DbHelper.groupColName: name,
      DbHelper.groupColTheme: theme.name,
      DbHelper.groupColSubj: subject,
      DbHelper.groupColSubSection: subSection
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map[DbHelper.groupColId],
      name: map[DbHelper.groupColName],
      theme: ThemeSelection.values.firstWhere((e) => e.name == map[DbHelper.groupColTheme]),
      subSection: map[DbHelper.groupColSubSection],
      subject: map[DbHelper.groupColSubj],
    );
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      DbHelper.groupColName: name,
      DbHelper.groupColTheme: theme.name,
      DbHelper.groupColSubj: subject,
      DbHelper.groupColSubSection: subSection
    };
  }

  Color get color => theme.color;
}

class Event {
  late String title;
  Event(this.title);
}
