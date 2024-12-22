import 'package:flutter/material.dart';
import 'package:myapp/model/model.dart';

class MainScreenTile extends StatefulWidget {
  MainScreenTile({
    super.key,
    required this.filtered,
  });

  final Participant filtered;
  String dropdownValue = "Present";

  @override
  State<MainScreenTile> createState() => _MainScreenTileState();
}

class _MainScreenTileState extends State<MainScreenTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.filtered.name),
      trailing: SizedBox(
        width: 150,
        child: Center(
          child: DropdownButton<String>(
            alignment: AlignmentDirectional.centerEnd,
            onChanged: (String? newValue){
              setState(() {
                widget.dropdownValue = newValue!;
              });
            },
            value: widget.dropdownValue,  
            items: [
              DropdownMenuItem<String>(
                alignment: AlignmentDirectional.center,
                child: Text("Present"),
                value: "Present",
              ),
              DropdownMenuItem<String>(
                 alignment: AlignmentDirectional.center,
                child: Text("Absent"),
                value: "Absent",
              ),
              DropdownMenuItem<String>(
                 alignment: AlignmentDirectional.center,
                child: Text("Late"),
                value: "Late",
              ),
              DropdownMenuItem<String>(
                 alignment: AlignmentDirectional.center,
                child: Text("Excused"),
                value: "Excused",
              ),
            ],
            
          ),
        ),
      ),
    );
  }
}
