import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy eggs'),
    Task(name: 'Buy bread'),
  ];

  int get tasksCount => _tasks.length;

  UnmodifiableListView get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addNewTask(Task newTask) {
    _tasks.add(newTask);
    notifyListeners();
  }

  void updateTaskDone(int taskIndex, bool changed) {
    _tasks[taskIndex].isDone = changed;
    notifyListeners();
  }

  void deleteTask(int taskIndex) {
    _tasks.remove(_tasks[taskIndex]);
    notifyListeners();
  }
}
