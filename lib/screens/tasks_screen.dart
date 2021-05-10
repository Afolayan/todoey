import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoey/helper/db_tasks.dart';
import 'package:todoey/helper/preference_helper.dart';
import 'package:todoey/models/task_group.dart';
import 'package:todoey/screens/task_screen_body.dart';

import 'add_task_screen.dart';
import 'create_new_task_screen.dart';

class TaskScreen extends StatefulWidget {
  static const String id = "TaskScreen";

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TaskGroup taskGroup;
  bool _newTaskFabVisibility = false;

  Future<TaskGroup> _setupData() async {
    _newTaskFabVisibility = true;
    if (taskGroup != null) {
      await saveLastGroupId(taskGroup.groupId);
      return taskGroup;
    }
    String groupId = await getLastGroupId();
    if (groupId != null) {
      taskGroup = await getGroupTaskById(groupId);
    } else {
      await taskGroups().then((value) async {
        taskGroup = value[0];
      });
    }
    await saveLastGroupId(taskGroup.groupId);
    return taskGroup;
  }

  void _refresh(TaskGroup taskGroup) {
    setState(() {
      this.taskGroup = taskGroup;
      _setupData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: Visibility(
        //visible: _newTaskFabVisibility,
        child: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add),
          onPressed: () async {
            await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddTaskScreen(groupId: taskGroup.groupId),
                    )));
            setState(() {
              _refresh(taskGroup);
            });
          },
        ),
      ),
      body: FutureBuilder(
        future: _setupData(),
        builder: (BuildContext context, AsyncSnapshot<TaskGroup> snapshot) {
          if (snapshot.hasData) {
            _newTaskFabVisibility = true;
            return TaskScreenBody(snapshot.data, _refresh);
          }
          //_newTaskFabVisibility = false;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "No item to display",
                  style: TextStyle(fontSize: 20.0),
                ),
                ElevatedButton(
                  child: Text("Create new task list"),
                  onPressed: () {
                    openNewTaskListBottomSheet();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future openNewTaskListBottomSheet() async {
    var newGroup = await showModalBottomSheet<TaskGroup>(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: CreateNewTaskScreen(),
            )));
    if (newGroup == null) return;
    setState(() {
      taskGroup = newGroup;
    });
  }
}
