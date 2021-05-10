import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todoey/db/app_database.dart';
import 'package:todoey/db/sqflite_database.dart';
import 'package:todoey/screens/task_group_screen.dart';
import 'package:todoey/screens/tasks_screen.dart';
import 'package:todoey/view_model.dart';

void main() {
  setupInjector();
  runApp(MyApp());
}

final getIt = GetIt.instance;
final viewModel = AppViewModel(getIt<AppDatabase>());
void setupInjector() {
  getIt.registerLazySingleton<AppDatabase>(() => SqfLiteDb());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todoey',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        TaskScreen.id: (context) => TaskScreen(),
        TaskGroupScreen.id: (context) => TaskGroupScreen(),
      },
      initialRoute: TaskScreen.id,
    );
  }
}
