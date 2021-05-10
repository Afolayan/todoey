import 'package:flutter/material.dart';
import 'package:todoey/helper/db_tasks.dart';
import 'package:todoey/models/task_group.dart';

import 'create_new_task_screen.dart';

class TaskGroupScreen extends StatefulWidget {
  static const String id = "TaskGroupScreen";
  List<TaskGroup> taskGroupList = [];

  @override
  _TaskGroupScreenState createState() => _TaskGroupScreenState();
}

class _TaskGroupScreenState extends State<TaskGroupScreen> {
  bool _fabVisibility = false;

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  void fetchList() {
    taskGroups().then((value) {
      setState(() {
        _fabVisibility = value.isNotEmpty;

        widget.taskGroupList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks List"),
      ),
      floatingActionButton: Visibility(
        visible: _fabVisibility,
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            onPressed: () {
              openNewTaskListBottomSheet();
            }),
      ),
      body: Container(
        child: _showContent(),
      ),
    );
  }

  Widget _showContent() {
    if (widget.taskGroupList.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.taskGroupList.length,
          itemBuilder: (context, index) {
            var taskGroup = widget.taskGroupList[index];
            return ListTile(
              title: Text(taskGroup.name),
              subtitle: Text(taskGroup.date),
              onTap: () {
                Navigator.pop(context, taskGroup);
              },
            );
          });
    } else {
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
    }
  }

  Future openNewTaskListBottomSheet() async {
    await showModalBottomSheet<TaskGroup>(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: CreateNewTaskScreen(),
            )));
    fetchList();
  }
}
