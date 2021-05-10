import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todoey/helper/db_tasks.dart';
import 'package:uuid/uuid.dart';

import 'task.dart';

class TaskGroup {
  int id;
  String groupId;
  String name;
  DateTime createdDate;
  DateTime updatedDate;

  List<Task> _taskList;

  String get date => DateFormat("MMM dd, yyyy hh:mm a").format(updatedDate);

  static TaskGroup newGroup(String name) {
    var createdDate = DateTime.now();
    var updatedDate = DateTime.now();
    var groupId = Uuid().v4();

    return TaskGroup(
        name: name,
        groupId: groupId,
        createdDate: createdDate,
        updatedDate: updatedDate);
  }

  TaskGroup(
      {@required this.name,
      this.id,
      this.groupId,
      this.createdDate,
      this.updatedDate});

  UnmodifiableListView get taskList {
    return UnmodifiableListView(_taskList);
  }

  int get tasksCount {
    if (_taskList == null) return 0;
    return _taskList.length;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'name': name,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'updatedDate': updatedDate.millisecondsSinceEpoch
    };
  }

  void updateDate() {
    createdDate = DateTime.now();
  }

  static TaskGroup fromMap(Map<String, dynamic> map) {
    return TaskGroup(
      id: map['id'],
      groupId: map['groupId'],
      name: map['name'],
      createdDate:
          DateTime.fromMicrosecondsSinceEpoch(map["createdDate"] * 1000),
      updatedDate:
          DateTime.fromMicrosecondsSinceEpoch(map["updatedDate"] * 1000),
    );
  }

  Future fetchTaskList() async {
    await taskGroupTasks(groupId).then((value) {
      if (value == null) {
        _taskList = [];
      } else {
        _taskList = value;
      }
    }, onError: (error) {
      _taskList = [];
    });
  }
}
