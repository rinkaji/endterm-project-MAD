import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';

class Mainscreen extends StatelessWidget {
  Mainscreen({super.key, required this.catID});

  var catID;
  @override
  Widget build(BuildContext context) {
    final filteredParticipant = participant.where((person)=>person.catID == catID).toList();
    return Scaffold(
      body: ListView.builder(
        itemCount: filteredParticipant.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(filteredParticipant[index].name);
        },
      ),
    );
  }
}