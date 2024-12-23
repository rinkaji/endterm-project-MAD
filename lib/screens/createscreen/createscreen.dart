import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/helper/dbHelper.dart';
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

  var input = TextEditingController();
  var id = category.length;
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
            onPressed: () {
              if (input.text.isNotEmpty) {
                widget.addcategory(input.text, id);
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => AddParticipantScreen(
                            catID: id,
                            catName: input.text,
                            catTheme: selectedTheme.color,
                          )),
                );
              }
              
            },
            child: Text(
              "Create",
              style: TextStyle(fontSize: 16, color: input.text.isEmpty ? Colors.grey : Colors.blue, fontWeight: FontWeight.w600),
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
              controller: input,
              onChanged: (input)=>setState((){}),
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
}
