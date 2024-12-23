import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/model/theme_selection.dart';
import 'package:myapp/screens/mainscreen/mainscreen.dart';

class AddParticipantScreen extends StatefulWidget {
  AddParticipantScreen({super.key, required this.catID, 
  required this.catName, 
  required this.catTheme, 
  // required this.cate
  });

  final int catID;
  final String catName;
  final ThemeSelection catTheme;
  // final Category cate;
  @override
  State<AddParticipantScreen> createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  var personCtrl = TextEditingController();
  List<Participant> tempParticipant = [];
  Color btnColor = Colors.grey.shade300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        //backgroundColor: widget.catTheme.color,
        
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          "Create Group",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () => 
              tempParticipant.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MainScreen(
                        catID: widget.catID,
                        //catName: widget.catName,
                        //catTheme:widget.catTheme,
                      ),
                    ),
                  )
                : adding(tempParticipant.length),
            child: (tempParticipant.isEmpty) ? Text("Skip",style: TextStyle(color: Colors.black, fontSize: 16),) : Text("Create",style: TextStyle(color: Colors.black, fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add people in ${widget.catName}",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
            SizedBox(height: 5,),
            TextField(
              controller: personCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (context)=>setState(() {}),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8),
                itemCount: tempParticipant.length,
                itemBuilder: (BuildContext context, int index) {
                  var person = tempParticipant[index];
                  return Card(
                    child: ListTile(
                      title: Text(person.name),
                      trailing: IconButton(
                        onPressed: participant.isEmpty
                            ? null
                            : () => removeParticipant(person),
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: personCtrl.text.isEmpty ? Colors.grey.shade300 : Colors.grey.shade300
                //widget.catTheme.color 
                ,
              ),
            onPressed: () => (personCtrl.text.isEmpty) ? null : addParticipant(),
            child: Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: personCtrl.text.isEmpty ? Colors.grey : Colors.black),),
            ),
          ),
          ],
        ),
      ),
    );
  }

  void addParticipant() {
    setState(() {
      // tempParticipant.add(
      //   Participant(ptID: widget.,catID: widget.catID, name: personCtrl.text),
      // );
      personCtrl.clear();
      print(tempParticipant.length);
    });
  }

  removeParticipant(Participant person) {
    setState(() {
      tempParticipant.remove(person);
      print(tempParticipant.length);
    });
  }

  adding(int filteredParticipant) {
    participant.addAll(tempParticipant);
    setState(() {
      tempParticipant.clear();
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MainScreen(
          catID: widget.catID,
          //catName: widget.catName,
          //catTheme: widget.catTheme,
        ),
      ),
    );
  }
}
