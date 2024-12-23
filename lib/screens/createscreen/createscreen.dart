import 'package:flutter/material.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/helper/dbHelper.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/model/theme_selection.dart';
import 'package:myapp/screens/add_participant_screen/addParticipantScreen.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({super.key, required this.addcategory});

  Function addcategory;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  void selectTheme() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: ThemeSelection.values.map((themeOption) {
                  return ListTile(
                    minTileHeight: 30,
                    leading: themeOption.icon,
                    title: Text(themeOption.name),
                    onTap: () {
                      setState(() {
                        selectedTheme = themeOption;
                      });
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          );
        });
  }

  var nameCtrl = TextEditingController();
  var subjCtrl = TextEditingController();
  var subSecCtrl = TextEditingController();
  int id = category.length;
  ThemeSelection selectedTheme = ThemeSelection.Sky;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        shadowColor: Colors.black.withValues(alpha: 1),
        elevation: 0.1,
        title: Text(
          "Create Group",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: createGroup,
            child: Text(
              "Create",
              style: TextStyle(
                  fontSize: 16,
                  color: nameCtrl.text.isEmpty ? Colors.grey : Colors.blue,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Group/Department/Class name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: nameCtrl,
              onChanged: (input) => setState(() {}),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Subsection",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: subSecCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Subject",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: subjCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Theme",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: selectTheme,
              child: ListTile(
                leading: selectedTheme.icon,
                title: Text(selectedTheme.name),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void fetchGroup() async {
  //   category = await DbHelper.fetchGroup();
  //   setState(() {});
  // }

  void createGroup() async {
    if (nameCtrl.text.isNotEmpty) {
      var category = Category.withoutId(
        name: nameCtrl.text,
        theme: selectedTheme,
        subSection: subSecCtrl.text,
        subject: subjCtrl.text,
      );
      
      var id = await DbHelper.createGroup(category);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AddParticipantScreen(
                catID: id,
              )));
    }
    widget.addcategory;
  }
}
