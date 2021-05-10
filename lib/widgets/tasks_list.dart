import 'package:flutter/material.dart';
import 'package:todoey/helper/db_tasks.dart';
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
              task.isDone = checkboxState;
              await updateTask(task);
              setState(() {});
              //taskData.updateTaskDone(index, checkboxState);
            },
            longPressCallback: () async {
              await deleteTask(task);
              setState(() {});
              //taskData.deleteTask(index);
            },
          );
        });
  }
}
