import 'package:flutter/material.dart';
import 'package:todoey/screens/task_group_screen.dart';
import 'package:todoey/screens/tasks_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        TaskScreen.id: (context) => TaskScreen(),
        TaskGroupScreen.id: (context) => TaskGroupScreen(),
      },
      initialRoute: TaskScreen.id,
    );
  }
}
