import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoey/helper/db_tasks.dart';
import 'package:todoey/models/task_group.dart';

class CreateNewTaskScreen extends StatelessWidget {
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
              "Add Task List",
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
            FlatButton(
              color: Colors.lightBlueAccent,
              child: Text(
                "Add List",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                if (newTaskText != null && newTaskText.isNotEmpty) {
                  var newGroup = TaskGroup.newGroup(newTaskText);

                  insertTaskGroup(newGroup).then((value) {
                    Fluttertoast.showToast(
                        msg: "New task list created successfully",
                        toastLength: Toast.LENGTH_SHORT);
                    Navigator.pop(context, newGroup);
                  }, onError: (error) {
                    Fluttertoast.showToast(
                        msg: "Error creating new task list created",
                        toastLength: Toast.LENGTH_SHORT);
                    Navigator.pop(context);
                  });
                } else {
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
