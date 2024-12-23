import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/helper/dbHelper.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/model/theme_selection.dart';
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
  void _longPressedDay(DateTime day, DateTime focusedDay) {
    var input = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Add Event"),
            content: TextField(
              controller: input,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (events[day] != null) {
                        events[day]?.add(Event(input.text));
                      } else {
                        events[day] = [Event(input.text)];
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Add")),
            ],
          );
        });
    setState(() {
      today = day;
    });
  }

  List<Event> eventsForDay(DateTime today) {
    return events[today] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final filteredParticipant =
        participant.where((person) => person.catID == widget.catID).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.catTheme.color,
          leading: IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Homescreen(),
              ),
            ),
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text(widget.catName.toString()),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(Icons.more),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  onDayLongPressed: _longPressedDay,
                  eventLoader: eventsForDay,
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
                  ListView.builder(
                    itemCount: eventsForDay(today).length,
                    itemBuilder: (BuildContext context, int index) {
                      print(eventsForDay(today).length);
                      var event = eventsForDay(today)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(event.title),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.cancel_rounded)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  FutureBuilder(
                      future: fetchMemebers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Align(alignment: Alignment.center, child: CircularProgressIndicator(),);
                        }
                        var members = snapshot.data;
                        return ListView.builder(
                          itemCount: members == null ? 0 : members.length,
                          itemBuilder: (BuildContext context, int index) {
                            var filtered = members![index];
                            return MainScreenTile(filtered: Participant.fromMap(filtered));
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
}
