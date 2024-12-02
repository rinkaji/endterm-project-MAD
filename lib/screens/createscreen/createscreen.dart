import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/screens/add_participant_screen/addParticipantScreen.dart';

class Createscreen extends StatelessWidget {
  Createscreen({super.key, required this.addcategory});

  var input = TextEditingController();
  Function addcategory;
  var id = category.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          "Create Group",
        ),
        actions: [
          TextButton(
            onPressed: () {
              if(input.text.isNotEmpty){
                addcategory(input.text, id);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => Addparticipantscreen(catID: id,)),
                );
              }
            },
            child: Text("Create"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Group/Department/Class name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: input,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Subsection",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Subject",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
