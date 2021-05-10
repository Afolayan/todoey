import 'package:flutter/material.dart';
import 'package:todoey/main.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_group.dart';
import 'package:todoey/screens/task_group_screen.dart';
import 'package:todoey/widgets/tasks_list.dart';

class TaskScreenBody extends StatefulWidget {
  TaskGroup taskGroup;
  final Function updateParentState;

  TaskScreenBody(this.taskGroup, this.updateParentState);

  @override
  _TaskScreenBodyState createState() => _TaskScreenBodyState();
}

class _TaskScreenBodyState extends State<TaskScreenBody> {
  Future<List<Task>> _taskListFuture;
  List<Task> _taskList;

  Future<List<Task>> _setupTaskList(String groupId) async {
    return await viewModel.getTaskGroupTasks(groupId);
  }

  @override
  void initState() {
    super.initState();
    _taskListFuture = _setupTaskList(widget.taskGroup.groupId);
  }

  void refresh() {
    widget.updateParentState(widget.taskGroup);
    _taskListFuture = _setupTaskList(widget.taskGroup.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
        future: _taskListFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            _taskList = snapshot.data;
          } else {
            _taskList = [];
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildScreenHeader(context),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                    ),
                  ),
                  child: _dataArea(snapshot),
                ),
              )
            ],
          );
        });
  }

  Container buildScreenHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 60.0,
        left: 30.0,
        right: 30.0,
        bottom: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: CircleAvatar(
              child: Icon(
                Icons.list,
                size: 30,
                color: Colors.indigoAccent,
              ),
              backgroundColor: Colors.white,
              radius: 30,
            ),
            onTap: () async {
              var newGroup =
                  await Navigator.pushNamed(context, TaskGroupScreen.id);
              setState(() {
                widget.taskGroup = newGroup;
                refresh();
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Todoey",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.w700),
          ),
          Visibility(
            visible: widget.taskGroup != null && widget.taskGroup.name != null,
            child: Text(
              "${widget.taskGroup.name ?? " "}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            taskCountText(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _dataArea(AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return Container();
    } else {
      _taskList = snapshot.data;
      if (_taskList == null || _taskList.length == 0) {
        return Container();
      }
      return TasksList(_taskList);
    }
  }

  String taskCountText() {
    int taskCount = _taskList.length;
    String countText;
    if (taskCount == 0) {
      countText = "No";
    } else {
      countText = "$taskCount";
    }
    return "$countText Tasks";
  }
}
