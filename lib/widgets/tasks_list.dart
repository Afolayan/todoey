import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/tasks_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
            itemCount: taskData.tasksCount,
            itemBuilder: (context, index) {
              var task = taskData.tasks[index];
              return TaskTile(
                taskTitle: task.name,
                isChecked: task.isDone,
                checkBoxCallback: (checkboxState) {
                  taskData.updateTaskDone(index, checkboxState);
                },
                longPressCallback: () {
                  taskData.deleteTask(index);
                },
              );
            });
      },
    );
  }
}
