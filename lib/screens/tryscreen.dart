import 'package:flutter/material.dart';
import 'package:myapp/helper/dbHelper.dart';

class Tryscreen extends StatelessWidget {
  const Tryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Dbhelper.openDb();
    return Scaffold();
  }
}