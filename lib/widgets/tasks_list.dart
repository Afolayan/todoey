import 'package:flutter/material.dart';
import 'package:todoey/main.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/widgets/tasks_tile.dart';

class TasksList extends StatefulWidget {
  final List<Task> taskList;

  TasksList(this.taskList);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.taskList.length,
        itemBuilder: (context, index) {
          var task = widget.taskList[index];
          return TaskTile(
            taskTitle: task.name,
            isChecked: task.isDone,
            checkBoxCallback: (checkboxState) async {
              await viewModel.updateTask(task, checkboxState);
              setState(() {});
            },
            longPressCallback: () async {
              await viewModel.deleteTask(task);
              setState(() {});
            },
          );
        });
  }
}
