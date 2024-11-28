import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  Homescreen({Key? key}) : super(key: key);

  List<String> category = [
    "Block A",
    "Block B",
    "Block C",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 45,
        ),
      ),
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: ListView.builder(
        itemCount: category.length,
        itemBuilder: (BuildContext context, int index) {
          var item = category[index];
          return ListTile(
            title: Text(item),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("edit"),
                ),
                PopupMenuItem(
                  onTap: () => print("mamammia"),
                  child: Text("delete"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
