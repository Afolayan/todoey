import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey/db/app_database.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_group.dart';

class SqfLiteDb implements AppDatabase<Database> {
  @override
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todoey_database.db'),
      onCreate: (db, version) {
        return _createDb(db, version);
      },
      version: 1,
    );
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
   create table $TABLE_TASK_GROUP (
    id integer primary key autoincrement,
    name text not null,
    groupId TEXT, 
    createdDate INTEGER, 
    updatedDate INTEGER
   )''');
    await db.execute('''
   create table $TABLE_TASK(
    id integer primary key autoincrement,
    name text not null,
    taskId TEXT, 
    isDone INTEGER, 
    groupId TEXT, 
    createdDate INTEGER
   )''');
  }

  @override
  Future<void> deleteTask(Task task) async {
    final db = await database();
    await db.delete(
      '$TABLE_TASK',
      where: "id = ?",
      whereArgs: [task.id],
    );
    await updateGroupAfterTaskChanges(task);
  }

  @override
  Future<void> deleteTaskGroupDb(int id) async {
    final db = await database();
    await db.delete(
      '$TABLE_TASK_GROUP',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<TaskGroup> getGroupTaskById(String groupId) async {
    final Database db = await database();

    final List<Map<String, dynamic>> maps = await db
        .query('$TABLE_TASK_GROUP', where: "groupId = ?", whereArgs: [groupId]);

    if (maps != null) {
      return Future.value(TaskGroup.fromMap(maps[0]));
    }
    return Future.value(null);
  }

  @override
  Future<int> insertTask(Task task) async {
    final Database db = await database();

    var insertID = await db.insert(
      '$TABLE_TASK',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await updateGroupAfterTaskChanges(task);

    return insertID;
  }

  @override
  Future<TaskGroup> insertTaskGroup(TaskGroup group) async {
    final Database db = await database();

    await db.insert(
      '$TABLE_TASK_GROUP',
      group.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return await getGroupTaskById(group.groupId);
  }

  @override
  Future<List<Task>> taskGroupTasks(String groupId) async {
    final Database db = await database();

    final List<Map<String, dynamic>> maps = await db.query('$TABLE_TASK',
        where: "groupId = ?", whereArgs: [groupId], orderBy: "isDone ASC");

    return Future.value(List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    }));
  }

  @override
  Future<List<TaskGroup>> taskGroups() async {
    final Database db = await database();

    final List<Map<String, dynamic>> maps =
        await db.query('$TABLE_TASK_GROUP', orderBy: "updatedDate DESC");

    return List.generate(maps.length, (i) {
      return TaskGroup.fromMap(maps[i]);
    });
  }

  @override
  Future updateGroupAfterTaskChanges(Task task) async {
    var taskGroup = await getGroupTaskById(task.groupId);
    taskGroup.updateDate();
    await updateTaskGroup(taskGroup);
  }

  @override
  Future<void> updateTask(Task taskUpdate) async {
    final db = await database();
    await db.update(
      '$TABLE_TASK',
      taskUpdate.toMap(),
      where: "id = ?",
      whereArgs: [taskUpdate.id],
    );
    await updateGroupAfterTaskChanges(taskUpdate);
  }

  @override
  Future<void> updateTaskGroup(TaskGroup group) async {
    final db = await database();
    await db.update(
      '$TABLE_TASK_GROUP',
      group.toMap(),
      where: "id = ?",
      whereArgs: [group.id],
    );
  }

  @override
  Future<Task> getTaskBy(String taskId) async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(
      '$TABLE_TASK',
      where: "taskId = ?",
      whereArgs: [taskId],
    );
    if (maps != null) {
      return Future.value(Task.fromMap(maps[0]));
    }
    return Future.value(null);
  }

  @override
  Future<Task> getTaskById(int id) async {
    final db = await database();

    final List<Map<String, dynamic>> maps = await db.query(
      '$TABLE_TASK',
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps != null) {
      return Future.value(Task.fromMap(maps[0]));
    }
    return Future.value(null);
  }
}
