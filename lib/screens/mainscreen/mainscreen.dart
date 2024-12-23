import 'package:flutter/material.dart';
import 'package:myapp/helper/dbHelper.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/model/theme_selection.dart';
import 'package:myapp/screens/add_participant_screen/addParticipantScreen.dart';
import 'package:myapp/screens/homescreen/homescreen.dart';
import 'package:myapp/screens/mainscreen/mainscreen_tile.dart';
import 'package:path/path.dart';
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
  Map<DateTime, List<Event>> events = {};

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
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>Homescreen())
                );
              },
              icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text(widget.catName.toString()),
        ),
        body: Column(
          children: [


            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  rowHeight: 43,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
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
                  FutureBuilder(future: fetchEvents(), builder: (Context, snapshot){
                    var events = snapshot.data;
                    return ListView.builder(
                      itemCount: events == null ? 0 : events.length,
                      itemBuilder: (BuildContext context, int index) {
                        var filtered = events![index];
                        return ListTile(
                          title: Text(filtered['${DbHelper.eventColName}']),
                          subtitle: Text(filtered["${DbHelper.eventColDate}"]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                              IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                  FutureBuilder(
                      future: fetchMemebers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                        }
                        var members = snapshot.data;
                        return ListView.builder(
                          itemCount: members == null ? 0 : members.length,
                          itemBuilder: (BuildContext context, int index) {
                            var filtered = members![index];
                            return MainScreenTile(
                              filtered: Participant.fromMap(filtered),
                              delMember: removeMember,
                              updateMember: editMember
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addEvent(input, day) {
    var event = Event.withoutId(title: input, date: day.toString(), groupId: widget.catID);
    DbHelper.addEvent(event);
    setState(() {});
  }
  Future<List<Map<String, dynamic>>> fetchEvents() {
    final events = DbHelper.fetchEvent(widget.catID);
    setState(() {});
    return events;
  }
}
