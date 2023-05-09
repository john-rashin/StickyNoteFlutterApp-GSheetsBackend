import 'package:flutter/material.dart';
import 'google_sheet_api.dart';

class MyTodoList extends StatefulWidget {
  const MyTodoList({super.key});

  @override
  State<MyTodoList> createState() => _MyTodoListState();
}

class _MyTodoListState extends State<MyTodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: GoogleSheetApi.currentNotes.length,
        itemBuilder: (BuildContext context, int index) {
           return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: GoogleSheetApi.currentNotes[index][1] == 0
                    ? Colors.grey[200]
                    : Colors.grey[300],
                child: CheckboxListTile(
                  value: GoogleSheetApi.currentNotes[index][1] == 0
                      ? false
                      : true,
                  onChanged: (newValue) {
                    GoogleSheetApi.update(index, newValue == false ? 0 : 1);
                    setState(() {
                      GoogleSheetApi.currentNotes[index][1] =
                          newValue == false ? 0 : 1;
                    });
                  },
                  title: Text(
                    GoogleSheetApi.currentNotes[index][0],
                    style: TextStyle(
                        color: GoogleSheetApi.currentNotes[index][1] == 0
                            ? Colors.grey[800]
                            : Colors.grey[500]),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
