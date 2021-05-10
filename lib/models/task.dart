import 'package:uuid/uuid.dart';

class Task {
  int id;
  String taskId;
  String groupId;
  final String name;
  bool isDone = false;
  DateTime createdDate;

  Task(
      {this.id,
      this.taskId,
      this.name,
      this.isDone = false,
      this.groupId,
      this.createdDate});

  static Task newTask({String name, String groupId}) {
    return Task(
      taskId: Uuid().v4(),
      name: name,
      groupId: groupId,
      createdDate: DateTime.now(),
    );
  }

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'groupId': groupId,
      'name': name,
      'isDone': isDone ? 1 : 0,
      'createdDate': createdDate.millisecondsSinceEpoch
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      taskId: map["taskId"],
      groupId: map["groupId"],
      name: map["name"],
      isDone: map["isDone"] == 1,
      createdDate:
          DateTime.fromMicrosecondsSinceEpoch(map["createdDate"] * 1000),
    );
  }
}
