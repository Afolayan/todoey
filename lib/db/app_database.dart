import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_group.dart';

const TABLE_TASK_GROUP = "task_group";
const TABLE_TASK = "task";

abstract class AppDatabase<DATABASE_TYPE> {
  Future<DATABASE_TYPE> database();

  Future<TaskGroup> insertTaskGroup(TaskGroup group);

  Future<List<TaskGroup>> taskGroups();

  Future<TaskGroup> getGroupTaskById(String groupId);

  Future<List<Task>> taskGroupTasks(String groupId);

  Future<void> updateTaskGroup(TaskGroup group);

  Future updateGroupAfterTaskChanges(Task task);

  Future<void> deleteTaskGroupDb(int id);

  Future<int> insertTask(Task task);

  Future<void> updateTask(Task taskUpdate);

  Future<Task> getTaskBy(String taskId);

  Future<Task> getTaskById(int id);

  Future<void> deleteTask(Task task);
}
