import 'package:flutter/material.dart';
import 'package:myapp/model/model.dart';

class MainScreenTile extends StatefulWidget {
  MainScreenTile({
    super.key,
    required this.filtered,
    required this.delMember,
    required this.updateMember,
  });

  final Participant filtered;
  final Function delMember;
  final Function updateMember;
  String dropdownValue = "Present";

  @override
  State<MainScreenTile> createState() => _MainScreenTileState();
}

class _MainScreenTileState extends State<MainScreenTile> {
  var memCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: openDialog,
      child: Card(
        child: ListTile(
          title: Text(widget.filtered.name),
          trailing: DropdownButton<String>(
            alignment: AlignmentDirectional.centerEnd,
            onChanged: (String? newValue) {
              setState(() {
                widget.dropdownValue = newValue!;
              });
            },
            value: widget.dropdownValue,
            items: [
              DropdownMenuItem<String>(
                alignment: AlignmentDirectional.center,
                child: Text("Present"),
                value: "Present",
              ),
              DropdownMenuItem<String>(
                alignment: AlignmentDirectional.center,
                child: Text("Absent"),
                value: "Absent",
              ),
              DropdownMenuItem<String>(
                alignment: AlignmentDirectional.center,
                child: Text("Late"),
                value: "Late",
              ),
              DropdownMenuItem<String>(
                alignment: AlignmentDirectional.center,
                child: Text("Excused"),
                value: "Excused",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text('Edit \"${widget.filtered.name}\"'),
                              content: TextField(
                                controller: memCtrl,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel')),
                                ElevatedButton(
                                    onPressed: () {
                                      widget.updateMember(Participant(
                                          ptID: widget.filtered.ptID,
                                          catID: widget.filtered.catID,
                                          name: memCtrl.text));
                                      
                                      memCtrl.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Edit'))
                              ],
                            );
                          });
                    },
                    child: ListTile(
                      title: Text("Edit"),
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                'Are you sure you want to delete \"${widget.filtered.name}\"?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel')),
                              ElevatedButton(
                                  onPressed: () {
                                    widget.delMember(widget.filtered.ptID);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Delete'))
                            ],
                          );
                        });
                  },
                  child: ListTile(
                    title: Text("Delete"),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
