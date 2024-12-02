import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/screens/createscreen/createscreen.dart';
import 'package:myapp/screens/homescreen/homescreen_card.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  void delete(id) {
    setState(() {
      category.removeAt(id);
      print(category.length);
    });
  }

  void edit(index, edited) {
    setState(() {
      category[index].name = edited;
    });
  }

  void add(added, id) {
    setState(() {
      category.add(
        Category(id: id, name: added),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Createscreen(
                      addcategory: add,
                    ))),
        child: Icon(
          Icons.add,
          size: 45,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 100,
        title: Text("Categories"),
      ),
      body: ListView.builder(
        itemCount: category.length,
        itemBuilder: (BuildContext context, int index) {
          var item = category[index].name;
          return HomescreenCard(
            item: item,
            deleteItem: delete,
            editItem: edit,
            index: index,
          );
        },
      ),
    );
  }
}
