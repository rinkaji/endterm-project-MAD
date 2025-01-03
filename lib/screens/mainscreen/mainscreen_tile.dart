import 'package:flutter/material.dart';
import 'package:myapp/helper/dbHelper.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/model/theme_selection.dart';
import 'package:myapp/screens/reports_screen/reports_screen.dart';

List membersStatus = [];

class MainScreenTile extends StatefulWidget {
  MainScreenTile(
      {super.key,
      required this.filtered,
      required this.delMember,
      required this.updateMember,
      required this.day,
      required this.theme,
      required this.index
    });


  final Participant filtered;
  final Function delMember;
  final Function updateMember;
  late ThemeSelection theme;
  final String day;
  final int index;

  @override
  State<MainScreenTile> createState() => _MainScreenTileState();
}

class _MainScreenTileState extends State<MainScreenTile> {
  List<Map<String, Object?>> test = [];
  String dropdownValue = "Status";
  var memCtrl = TextEditingController();
  
  addAttendance(date) async {
    int id = await DbHelper.addAttendance(Attendance.withoutId(
        group_id: widget.filtered.catID,
        member_id: widget.filtered.ptID!,
        date: date.toString().split(" ")[0],
        status: dropdownValue));
    return "attendance $id added to the";
  }

  Future<List<Map<String, Object?>>>? fetchStatus() async {
    var result = await DbHelper.fetchStatus(
        widget.filtered.ptID!, widget.filtered.catID, widget.day);
    return result;
  }

  Future<String>convertFutureToString(
      Future<List<Map<String, Object?>>>? futureListMap) async {
    try {
      List<Map<String, Object?>> listMap = await futureListMap!;
      var result = listMap[0];
      var anotherResult = Attendance.fromMap(result);
      return anotherResult.status;
    } catch (e) {
      return "Error: $e"; 
    }
  }

  converter(Future<String> convert) async {
    var result = await convert;
    return result;
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: openDialog,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          title: Text(widget.filtered.name),
          trailing: FutureBuilder(
            future: convertFutureToString(fetchStatus()),
            builder: (context, snapshot) {
              var result = snapshot.data;
              print(result);
              if(result!= "Present" && result!= "Absent" && result!= "Late" && result!= "Excused"){
                dropdownValue = "Status";
              }
              else{
                dropdownValue = result!;
              }
              
              return DropdownButton<String>(
                alignment: AlignmentDirectional.centerEnd,
                onChanged: (String? newValue) {
                  String oldvalue = dropdownValue;
                  setState(() {
                    dropdownValue = newValue!;
                  });
                  if (oldvalue != dropdownValue && dropdownValue != "Status") {
                    addAttendance(widget.day.toString().split(" ")[0]);
                    print(widget.day);
                  }
                  print(widget.filtered.name);
                },
                value: dropdownValue,
                items: [
                  DropdownMenuItem<String>(
                    alignment: AlignmentDirectional.center,
                    child: Text("Status"),
                    value: "Status",
                  ),
                  DropdownMenuItem<String>(
                    alignment: Alignment.centerLeft,
                    child: Text("Present"),
                    value: "Present",
                  ),
                  DropdownMenuItem<String>(
                    alignment: Alignment.centerLeft,
                    child: Text("Absent"),
                    value: "Absent",
                  ),
                  DropdownMenuItem<String>(
                    alignment: Alignment.centerLeft,
                    child: Text("Late"),
                    value: "Late",
                  ),
                  DropdownMenuItem<String>(
                    alignment: Alignment.centerLeft,
                    child: Text("Excused"),
                    value: "Excused",
                  ),
                ],
              );
            },
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
                ListTile(
                  title: Text("Edit"),
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
                              decoration:
                                  InputDecoration(border: OutlineInputBorder()),
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
                ),
                ListTile(
                  title: Text("Delete"),
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
                ),
                ListTile(
                  title: Text('Reports'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ReportsScreen(
                            participant: widget.filtered,
                            theme: widget.theme,

                          ))),
                )
              ],
            ),
          );
        });
  }
}
