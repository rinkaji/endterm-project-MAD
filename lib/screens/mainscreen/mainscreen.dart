import 'package:flutter/material.dart';
import 'package:myapp/helper/dbHelper.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/model/theme_selection.dart';
import 'package:myapp/screens/add_participant_screen/addParticipantScreen.dart';
import 'package:myapp/screens/homescreen/homescreen.dart';
import 'package:myapp/screens/mainscreen/mainscreen_tile.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreen extends StatefulWidget {
  MainScreen(
      {super.key,
      required this.catID,
      required this.catName,
      required this.catTheme});

  final int catID;
  final String catName;
  final ThemeSelection catTheme;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var input = TextEditingController();

  void editMember(Participant participant) {
    DbHelper.updateMember(participant);
    setState(() {});
  }

  void removeMember(int id) {
    DbHelper.deleteMember(id);
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> fetchMemebers() {
    final members = DbHelper.fetchMember(widget.catID);
    setState(() {});
    return members;
  }

  //for calendar day selection
  var today = DateTime.now();
  void selectedDay(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  //for creating events in calendar
  List<Map<String, dynamic>>? allMember = [];
  String status="";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          elevation: 3,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddParticipantScreen(
                          catID: widget.catID,
                          catName: widget.catName,
                          catTheme: widget.catTheme,
                        )));
          },
          backgroundColor: widget.catTheme.color,
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 45,
          ),
        ),
        appBar: AppBar(
          backgroundColor: widget.catTheme.color,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Homescreen()));
              },
              icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text(widget.catName),
          actions: [TextButton(onPressed: ()=>addAttendance, child: Text("Submit"))],
        ),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  onDayLongPressed: (selectedDay, focusedDay) =>
                      openDialog(context, selectedDay),
                  rowHeight: 43,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2030, 3, 14),
                  onDaySelected: selectedDay,
                ),
              ),
            ),
            TabBar(
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  text: "Events",
                ),
                Tab(
                  text: "Members",
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder(
                      future: fetchEvents(),
                      builder: (Context, snapshot) {
                        var events = snapshot.data;
                        return ListView.builder(
                          itemCount: events == null ? 0 : events.length,
                          itemBuilder: (BuildContext context, int index) {
                            var filtered = events![index];
                            return ListTile(
                              title: Text(filtered['${DbHelper.eventColName}']),
                              subtitle:
                                  Text(filtered["${DbHelper.eventColDate}"]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () => editEvent(
                                          filtered[DbHelper.eventColId],
                                          filtered[DbHelper.eventColName],
                                          today,
                                          widget.catID,
                                          context),
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () => deleteEvent(
                                          filtered[DbHelper.eventColId]),
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                  FutureBuilder(
                    future: fetchMemebers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                      }
                      var members = snapshot.data;
                      allMember = members;
                      return ListView.builder(
                        itemCount: members == null ? 0 : members.length,
                        itemBuilder: (BuildContext context, int index) {
                          var filtered = members![index];
                          return MainScreenTile(
                              // addAttendance: addAttendance,
                              filtered: Participant.fromMap(filtered),
                              delMember: removeMember,
                              updateMember: editMember,
                              theme: widget.catTheme,
                              day: today
                              );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openDialog(ctx, day) {
    setState(() {
      today = day;
    });
    showDialog(
        context: ctx,
        builder: (_) {
          return AlertDialog(
            title: Text("Add Event"),
            content: TextField(
              controller: input,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(ctx), child: Text("cancel")),
              ElevatedButton(
                  onPressed: () => addEvent(day, ctx), child: Text("Add")),
            ],
          );
        });
  }

  void addEvent(day, ctx) {
    if (input.text.isNotEmpty) {
      var event = Event.withoutId(
          title: input.text,
          date: day.toString().split(" ")[0],
          groupId: widget.catID);
      DbHelper.addEvent(event);
      setState(() {});
      Navigator.pop(ctx);
      input.clear();
    }
  }

  Future<List<Map<String, dynamic>>> fetchEvents() {
    final events = DbHelper.fetchEvent(widget.catID);
    setState(() {});
    return events;
  }

  void deleteEvent(int eventId) {
    DbHelper.deleteEvent(eventId);
    setState(() {});
  }

  void editEvent(int eventId, String eventName, date, int id, ctx) {
    var editCtrl = TextEditingController(text: eventName);

    showDialog(
      context: ctx,
      builder: (_) {
        return AlertDialog(
          title: Text("Edit Event"),
          content: TextField(
            controller: editCtrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(ctx), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (editCtrl.text.isNotEmpty) {
                  DbHelper.updateEvent(
                    Event(
                      id: eventId,
                      title: editCtrl.text,
                      date: date.toString().split(" ")[0],
                      groupId: id,
                    ),
                  );
                  setState(() {});
                  Navigator.pop(ctx);
                }
              },
              child: Text("Edit"),
            ),
          ],
        );
      },
    );
  }
  void addAttendance(DateTime date){
    print("added an input");
  }
  
}
