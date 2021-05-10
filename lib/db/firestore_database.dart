import 'package:todoey/db/app_database.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_group.dart';

class FireStoreDatabase implements AppDatabase {
  @override
  Future database() {
    // TODO: implement database
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(Task task) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTaskGroupDb(int id) {
    // TODO: implement deleteTaskGroupDb
    throw UnimplementedError();
  }

  @override
  Future<TaskGroup> getGroupTaskById(String groupId) {
    // TODO: implement getGroupTaskById
    throw UnimplementedError();
  }

  @override
  Future<Task> getTaskBy(String taskId) {
    // TODO: implement getTaskBy
    throw UnimplementedError();
  }

  @override
  Future<Task> getTaskById(int id) {
    // TODO: implement getTaskById
    throw UnimplementedError();
  }

  @override
  Future<int> insertTask(Task task) {
    // TODO: implement insertTask
    throw UnimplementedError();
  }

  @override
  Future<TaskGroup> insertTaskGroup(TaskGroup group) {
    // TODO: implement insertTaskGroup
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> taskGroupTasks(String groupId) {
    // TODO: implement taskGroupTasks
    throw UnimplementedError();
  }

  @override
  Future<List<TaskGroup>> taskGroups() {
    // TODO: implement taskGroups
    throw UnimplementedError();
  }

  @override
  Future updateGroupAfterTaskChanges(Task task) {
    // TODO: implement updateGroupAfterTaskChanges
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task taskUpdate) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTaskGroup(TaskGroup group) {
    // TODO: implement updateTaskGroup
    throw UnimplementedError();
  }

}