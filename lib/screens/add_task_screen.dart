import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/helper/db_tasks.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/screens/tasks_screen.dart';

class AddTaskScreen extends StatelessWidget {
  final String groupId;

  AddTaskScreen({this.groupId});

  @override
  Widget build(BuildContext context) {
    String newTaskText;
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Task",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, color: Colors.lightBlueAccent),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                newTaskText = newValue;
              },
            ),
            SizedBox(
              height: 30,
            ),
            Provider(
              create: (context) => TaskData(),
              child: FlatButton(
                color: Colors.lightBlueAccent,
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  if (newTaskText != null && newTaskText.isNotEmpty) {
                    var newTask =
                        Task.newTask(name: newTaskText, groupId: groupId);
                    await insertTask(newTask).then((value) {
                      Navigator.pushReplacementNamed(context, TaskScreen.id);
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
