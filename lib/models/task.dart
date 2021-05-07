import 'package:uuid/uuid.dart';

class Task {
  String id;
  String groupId;
  final String name;
  bool isDone = false;
  DateTime createdDate;

  Task(
      {this.id,
      this.name,
      this.isDone = false,
      this.groupId,
      this.createdDate});

  static Task newTask(String name, String groupId) {
    return Task(
      id: Uuid().v4(),
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
      'groupId': groupId,
      'name': name,
      'isDone': isDone,
      'createdDate': createdDate.millisecond
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      groupId: map["groupId"],
      name: map["name"],
      isDone: map["isDone"],
      createdDate: DateTime.parse(map["createdDate"].toString()),
    );
  }
}
