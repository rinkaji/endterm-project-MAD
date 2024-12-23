import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/helper/dbHelper.dart';
<<<<<<< HEAD
import 'package:myapp/model/model.dart';
=======
>>>>>>> 122382236436f4a64b4e3f1a96d625bb4d5aead2
import 'package:myapp/screens/createscreen/createscreen.dart';
import 'package:myapp/screens/homescreen/homescreen_card.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // createGroup(String name, int id) async {
  //     final newCatge
  //     DbHelper.createGroup(category);

  // }

  void fetchGroup() async {
    category = await DbHelper.fetchGroup();
    setState(() {});
  }

  void delete(id) {
    setState(() {
      category.removeAt(id);
      print(category.length);
    });
  }

  void edit(int index, edited) {
    setState(() {
      category[index].name = edited;
    });
  }

  void add(added, id) {
    setState(() {
      fetchGroup();
    });
  }

  @override
  Widget build(BuildContext context) {
    Dbhelper.openDb();
    print(category.length);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          elevation: 3,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateScreen(
                addcategory: fetchGroup,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            size: 45,
            color: Color.fromRGBO(33, 37, 255, 1),
          ),
        ),
        appBar: AppBar(
          shadowColor: Colors.black.withValues(alpha: 1),
          elevation: 0.1,
          automaticallyImplyLeading: false,
          title: Text("Asanna",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 24)),
        ),
        body: FutureBuilder(
          future: DbHelper.fetchGroup(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var category = snapshot.data;
            return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 3 / 2,
              crossAxisCount: 2),
            itemCount: category == null ? 0 : category.length,
            itemBuilder: (BuildContext context, int index) {
              final item = category![index];
              return HomeScreenCard(
                item: item,
                deleteItem: delete,
                editItem: edit,
              );
            }
  );
          },
        ));
  }

  void fetchCategories() async {
    final result = await DbHelper.fetchGroup();
    setState(() {
      category = result;
    });
  }
}
