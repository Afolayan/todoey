import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_group.dart';

const TABLE_TASK_GROUP = "task_group";
const TABLE_TASK = "task";

Future<Database> getDatabase({String name = "todoey_database"}) async {
  return openDatabase(
    join(await getDatabasesPath(), '$name.db'),
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

Future<void> insertTaskGroup(TaskGroup group) async {
  final Database db = await getDatabase();

  await db.insert(
    '$TABLE_TASK_GROUP',
    group.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<TaskGroup>> taskGroups() async {
  final Database db = await getDatabase();

  final List<Map<String, dynamic>> maps =
      await db.query('$TABLE_TASK_GROUP', orderBy: "updatedDate DESC");

  return List.generate(maps.length, (i) {
    return TaskGroup.fromMap(maps[i]);
  });
}

Future<List<Task>> taskGroupTasks(String groupId) async {
  final Database db = await getDatabase();

  final List<Map<String, dynamic>> maps = await db.query('$TABLE_TASK',
      where: "groupId = ?", whereArgs: [groupId], orderBy: "isDone ASC");

  return Future.value(List.generate(maps.length, (i) {
    return Task.fromMap(maps[i]);
  }));
}

Future<TaskGroup> getGroupTaskById(String groupId) async {
  final Database db = await getDatabase();

  final List<Map<String, dynamic>> maps = await db
      .query('$TABLE_TASK_GROUP', where: "groupId = ?", whereArgs: [groupId]);

  if (maps != null) {
    return Future.value(TaskGroup.fromMap(maps[0]));
  }
  return Future.value(null);
}

Future<void> updateTaskGroup(TaskGroup group) async {
  final db = await getDatabase();
  await db.update(
    '$TABLE_TASK_GROUP',
    group.toMap(),
    where: "id = ?",
    whereArgs: [group.id],
  );
}

Future updateGroupAfterTaskChanges(Task task) async {
  var taskGroup = await getGroupTaskById(task.groupId);
  taskGroup.updateDate();
  await updateTaskGroup(taskGroup);
}

Future<void> deleteTaskGroupDb(int id) async {
  final db = await getDatabase();
  await db.delete(
    '$TABLE_TASK_GROUP',
    where: "id = ?",
    whereArgs: [id],
  );
}

///TASKS db Calls

Future<int> insertTask(Task task) async {
  final Database db = await getDatabase();

  var insertID = await db.insert(
    '$TABLE_TASK',
    task.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  await updateGroupAfterTaskChanges(task);

  return insertID;
}

Future<void> updateTask(Task taskUpdate) async {
  final db = await getDatabase();
  await db.update(
    '$TABLE_TASK',
    taskUpdate.toMap(),
    where: "id = ?",
    whereArgs: [taskUpdate.id],
  );
  await updateGroupAfterTaskChanges(taskUpdate);
}

Future<void> deleteTask(Task task) async {
  final db = await getDatabase();

  await db.delete(
    '$TABLE_TASK',
    where: "id = ?",
    whereArgs: [task.id],
  );
  await updateGroupAfterTaskChanges(task);
}
