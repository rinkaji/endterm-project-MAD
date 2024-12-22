import 'package:flutter/material.dart';
import 'package:myapp/model/model.dart';

class mainscreenTile extends StatefulWidget {
  mainscreenTile({
    super.key,
    required this.filtered,
  });

  final Participant filtered;
  String dropdownValue = "Present";

  @override
  State<mainscreenTile> createState() => _mainscreenTileState();
}

class _mainscreenTileState extends State<mainscreenTile> {
  @override
  Widget build(BuildContext context) {
    

    return ListTile(
      title: Text(widget.filtered.name),
      trailing: DropdownButton<String>(
        onChanged: (String? newValue){
          setState(() {
            widget.dropdownValue = newValue!;
          });
        },
        value: widget.dropdownValue,
        items: [
          DropdownMenuItem<String>(
            child: Text("Present"),
            value: "Present",
          ),
          DropdownMenuItem<String>(
            child: Text("Absent"),
            value: "Absent",
          ),
          DropdownMenuItem<String>(
            child: Text("Late"),
            value: "Late",
          ),
          DropdownMenuItem<String>(
            child: Text("Excused"),
            value: "Excused",
          ),
        ],
        
      ),
    );
  }
}
