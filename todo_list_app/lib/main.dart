import 'package:flutter/material.dart';
import 'package:todo_list_app/google_sheet_api.dart';
import 'package:todo_list_app/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
