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
              child: TableCalendar(
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime(2030, 3, 14),
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
                  Text("Mamam"),
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
