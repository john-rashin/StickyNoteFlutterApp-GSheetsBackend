import 'package:flutter/material.dart';
import 'package:todo_list_app/google_sheet_api.dart';
import 'package:todo_list_app/textbox.dart';

class NotesGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: GoogleSheetApi.currentNotes.length,
        gridDelegate: 
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return MyTextBox(text: GoogleSheetApi.currentNotes[index][0]);
        });
  }
}
