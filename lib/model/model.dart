import 'package:flutter/material.dart';

import 'package:myapp/helper/dbHelper.dart';
import 'package:myapp/model/theme_selection.dart';

class Participant {
  late int catID;
  late int ptID;
  late String name;

  Participant({required this.ptID, required this.catID, required this.name});
}

class Category {
  late int id;
  late String name;
  late ThemeSelection theme;
  String? subject;
  String? subSection;
  Category(
      {required this.id, required this.name, required this.theme, this.subject, this.subSection});

  Category.withoutId({required this.name, required this.theme, this.subject, this.subSection});

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
      id: map['id'],
      name: map['name'],
      theme: ThemeSelection.values.firstWhere((e) => e.name == map['theme']),
      subSection: map['subSection'],
      subject: map['subject'],
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