import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/screens/homescreen/homescreen_card.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  void delete(item){
    setState(() {
      category.remove(item);
    });
  }

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
          return HomescreenCard(item: item, deleteItem: delete,);
        },
      ),
    );
  }
}


