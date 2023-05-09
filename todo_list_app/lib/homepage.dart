import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list_app/button.dart';
import 'package:todo_list_app/google_sheet_api.dart';
import 'package:todo_list_app/list_view.dart';
import 'package:todo_list_app/loading_circle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  void _post() {
    GoogleSheetApi.insert(_controller.text);
    _controller.clear();
    setState(() {});
  }

//wait for the data to fetch from the google spreedsheet
  void startLoading() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetApi.loading == true) {
      startLoading();
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Things To Do',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.yellow[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: GoogleSheetApi.loading == true
                  ? LoadingCircle()
                  : MyTodoList(),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter...',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Created By: R A S H I N'),
                    ),
                    MyButton(
                      text: 'S A V E',
                      function: _post,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
