import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:josesanchez_flutterapp_todo/src/modules/todo/ToDoPage.dart';


void main() {
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoPage(),
    );
  }
}