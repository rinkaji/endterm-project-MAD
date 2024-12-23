import 'package:flutter/material.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/screens/mainscreen/mainscreen.dart';

class HomeScreenCard extends StatelessWidget {
  HomeScreenCard({
    super.key,
    required this.item,
    required this.deleteItem,
    required this.editItem,

  });

  final Category item;
  Function deleteItem;
  Function editItem;
  var categoryName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MainScreen(
                catID: item.id,
                catName: item.name,
                catTheme: item.theme,
              ),
            ),
          );
        },
        child: GridTile(
            header: GridTileBar(
              title: Text(
                item.name,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  iconColor: Colors.black,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        height: 30,
                        onTap: () => openDialog(context),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                      PopupMenuItem(
                        height: 30,
                        onTap: () => deleteItem(item.id),
                        child: Text("Delete",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                      ),
                    ];
                  }),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ))
        );
  }

  void openDialog(ctx) {
    showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
              title: Text("edit"),
              content: TextField(
                controller: categoryName =
                    TextEditingController(text: item.name),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(ctx), child: Text("cancel")),
                ElevatedButton(
                    onPressed: () {
                      editItem(item.id, categoryName.text.toString());
                      Navigator.pop(ctx);
                    },
                    child: Text("edit")),
              ],
            ));
  }
}
