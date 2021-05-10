import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkBoxCallback;
  final Function longPressCallback;

  TaskTile(
      {@required this.taskTitle,
      this.isChecked,
      this.checkBoxCallback,
      this.longPressCallback});

  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(
        taskTitle,
        style: isChecked
            ? TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      trailing: Checkbox(
        value: isChecked,
        activeColor: Colors.indigoAccent,
        onChanged: checkBoxCallback,
      ),
    );
  }
}
