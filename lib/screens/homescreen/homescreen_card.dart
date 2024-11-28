import 'package:flutter/material.dart';

class HomescreenCard extends StatelessWidget {
  HomescreenCard({
    super.key,
    required this.item,
    required this.deleteItem,
  });

  final String item;
  Function deleteItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("edit"),
            ),
            PopupMenuItem(
              onTap: () => deleteItem(item),
              child: Text("delete"),
            ),
          ],
        ),
      ),
    );
  }
}