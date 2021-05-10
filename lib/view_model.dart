import 'package:todoey/db/app_database.dart';
import 'package:todoey/models/task_group.dart';

import 'models/task.dart';

class AppViewModel {
  AppDatabase _appDatabase;

  AppViewModel(this._appDatabase);

  Future<TaskGroup> createNewTaskGroup(String groupName) async {
    TaskGroup group = TaskGroup.newGroup(groupName);
    return await _appDatabase.insertTaskGroup(group);
  }

  Future<List<TaskGroup>> fetchAllTaskGroups() async {
    return await _appDatabase.taskGroups();
  }

  Future<TaskGroup> getFirstTaskGroup() async {
    return await _appDatabase.taskGroups().then((value) => value[0]);
  }

  Future<TaskGroup> getGroupTask(String groupId) async {
    return await _appDatabase.getGroupTaskById(groupId);
  }

  Future<List<Task>> getTaskGroupTasks(String groupId) async {
    return await _appDatabase.taskGroupTasks(groupId);
  }

  Future deleteTaskGroup(int id) {
    return _appDatabase.deleteTaskGroupDb(id);
  }

  Future updateTaskGroup(TaskGroup taskGroup) {
    return _appDatabase.updateTaskGroup(taskGroup);
  }

  Future createNewTask(String taskName, String groupId) async {
    var newTask = Task.newTask(name: taskName, groupId: groupId);
    await _appDatabase.insertTask(newTask);
  }

  Future<Task> getTask(String taskId) async {
    return await _appDatabase.getTaskBy(taskId);
  }

  Future getTaskById(int id) async {
    await _appDatabase.getTaskById(id);
  }

  Future deleteTaskById(String taskId) async {
    var task = await getTask(taskId);
    await _appDatabase.deleteTask(task);
  }

  Future deleteTask(Task task) async {
    await _appDatabase.deleteTask(task);
  }

  Future updateTask(Task task, bool isDone) {
    task.isDone = isDone;
    return _appDatabase.updateTask(task);
  }
}
