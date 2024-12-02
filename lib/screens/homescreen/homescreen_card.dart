import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';

class HomescreenCard extends StatelessWidget {
  HomescreenCard({
    super.key,
    required this.item,
    required this.deleteItem,
    required this.editItem,
    required this.index,
  });

  final String item;
  Function deleteItem;
  Function editItem;
  int index;
  var categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
        left: 12,
        right: 12,
      ),
      child: SizedBox(
        height: 100,
        child: Card(
          child: ListTile(
            title: Text(item),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => openDialog(context),
                  child: Text("edit"),
                ),
                PopupMenuItem(
                  onTap: () => deleteItem(index),
                  child: Text("delete"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  openDialog(ctx) {
    showDialog(context: ctx, builder: (_)=>AlertDialog(
      title: Text("edit"),
      content: TextField(
        controller:  categoryName = TextEditingController(text: item),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        ElevatedButton(onPressed: ()=>Navigator.pop(ctx), child: Text("cancel")),
        ElevatedButton(onPressed: (){
          editItem(index, categoryName.text.toString());
          Navigator.pop(ctx);
        }, child: Text("edit")),
      ],
    ));
  }
}
