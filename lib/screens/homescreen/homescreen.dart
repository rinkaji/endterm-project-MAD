import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/screens/createscreen/createscreen.dart';
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
  void edit(index, edited){
    setState(() {
      category[index] = edited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Createscreen())),
        child: Icon(
          Icons.add,
          size: 45,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Text("Categories"),
      ),
      body: ListView.builder(
        itemCount: category.length,
        itemBuilder: (BuildContext context, int index) {
          var item = category[index];
          return HomescreenCard(item: item, deleteItem: delete, editItem: edit, index: index,);
        },
      ),
    );
  }
}


