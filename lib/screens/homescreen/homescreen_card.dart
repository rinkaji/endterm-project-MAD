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
                  onTap: () => editItem(),
                  child: Text("edit"),
                ),
                PopupMenuItem(
                  onTap: () => deleteItem(item),
                  child: Text("delete"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  editItem() {
    
  }
}
