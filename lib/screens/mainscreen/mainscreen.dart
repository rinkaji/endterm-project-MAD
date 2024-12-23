import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/screens/homescreen/homescreen.dart';
import 'package:myapp/screens/mainscreen/mainscreen_tile.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreen extends StatefulWidget {
  MainScreen(
      {super.key,
      required this.catID,
      required this.catName,
      required this.catTheme});

  int catID;
  var catName;
  var catTheme;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  //for calendar day selection
  var today = DateTime.now();
  void selectedDay(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }


  //for creating events in calendar
  Map<DateTime, List<Event>> events = {};
  void _longPressedDay(DateTime day, DateTime focusedDay){
    
    var input = TextEditingController();
    showDialog(context: context, builder: (_){
      return AlertDialog(
        title: Text("Add Event"),
        content: TextField(
          controller: input,
          decoration: InputDecoration(
            border: OutlineInputBorder()
          ),
        ),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: (){
           setState(() {
            if (events[day] != null) {
              events[day]?.add(Event(input.text));
            } else {
              events[day] = [Event(input.text)];
            }
          });
          Navigator.pop(context);
          }, child: Text("Add")),
        ],
      );
    });
    setState(() {
      today = day;
    });
  }
  List<Event> eventsForDay(DateTime today){
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
          backgroundColor: widget.catTheme,
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
                                IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                                IconButton(onPressed: (){}, icon: Icon(Icons.cancel_rounded)),
                                ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: filteredParticipant.length,
                    itemBuilder: (BuildContext context, int index) {
                      var filtered = filteredParticipant[index];
                      return MainScreenTile(filtered: filtered);
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
}
