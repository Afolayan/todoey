import 'package:flutter/material.dart';
import 'package:todoey/db/db_tasks.dart';
import 'package:todoey/models/task_group.dart';

class TaskGroupScreen extends StatefulWidget {
  static const String id = "TaskGroupScreen";
  List<TaskGroup> taskGroupList = [];

  @override
  _TaskGroupScreenState createState() => _TaskGroupScreenState();
}

class _TaskGroupScreenState extends State<TaskGroupScreen> {
  @override
  void initState() async {
    super.initState();
    widget.taskGroupList = await taskGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks List"),
      ),
      body: Container(
        child: ListView.builder(itemBuilder: (context, index) {
          var taskGroup = widget.taskGroupList[index];
          return ListTile(
            title: Text(taskGroup.name),
            subtitle: Text(taskGroup.date),
            onTap: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
    );
  }
}
