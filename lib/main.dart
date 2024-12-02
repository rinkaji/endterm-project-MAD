import 'package:flutter/material.dart';
import 'package:myapp/screens/createscreen/createscreen.dart';
import 'package:myapp/screens/homescreen/homescreen.dart';
import 'package:myapp/screens/loginscreen/loginscreen.dart';

void main() {
  runApp(
    myApp(),
  );
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
