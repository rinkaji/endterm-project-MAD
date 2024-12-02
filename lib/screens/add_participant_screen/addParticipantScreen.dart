import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/screens/mainscreen/mainscreen.dart';

class Addparticipantscreen extends StatefulWidget {
  Addparticipantscreen({
    super.key,
    required this.catID,
  });

  var catID;

  @override
  State<Addparticipantscreen> createState() => _AddparticipantscreenState();
}

class _AddparticipantscreenState extends State<Addparticipantscreen> {
  var personCtrl = TextEditingController();

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
        title: Text("Add Participant"),
        actions: [
          TextButton(
            onPressed: () => tempParticipant.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Mainscreen(catID: widget.catID,),
                    ),
                  )
                : adding(tempParticipant.length),
            child: (tempParticipant.isEmpty) ? Text("Skip") : Text("Create"),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("Add people to this (category name)"),
          TextField(
            controller: personCtrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tempParticipant.length,
              itemBuilder: (BuildContext context, int index) {
                var person = tempParticipant[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    right: 10,
                    left: 10,
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(person.name),
                      trailing: IconButton(
                        onPressed: participant.isEmpty
                            ? null
                            : () => removeParticipant(person),
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 300,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                personCtrl.text.isEmpty ? Colors.grey.shade300 : Colors.blue,
          ),
          onPressed: () => (personCtrl.text.isEmpty) ? null : addParticipant(),
          child: Text("Add"),
        ),
      ),
    );
  }

  addParticipant() {
    setState(() {
      tempParticipant.add(
        Participant(catID: widget.catID, name: personCtrl.text),
      );
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
        builder: (_) => Mainscreen(catID:  widget.catID),
      ),
    );
  }
}
