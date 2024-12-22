import 'package:flutter/material.dart';
import 'package:myapp/model/theme_selection.dart';

class Participant {
  late int catID;
  late String name;

  Participant({required this.catID, required this.name});
}

class Category {
  late int id;
  late String name;
  late ThemeSelection theme;

  Category({required this.id, required this.name, this.theme = ThemeSelection.Sky});

  Color get color => theme.color;
}


class Event {
  late String title;
  Event(this.title);
}