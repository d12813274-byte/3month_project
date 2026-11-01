import 'package:flutter_month3/database/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDatabase {
  final Box box = Hive.box("todoBox");
  List<Todo> _todoList = [];
  

  void saveTodos() {
    final data = _todoList.map((todo) {
      return {
        "id": todo.id,
        "title": todo.title,
        "isDone": todo.isDone,
        "createAt": todo.createAt,
        "deadline": todo.deadline,
      };
    }).toList();
    box.put("todos", data);
  }

  List<Todo> getTodoList() {
    final data = box.get("todos", defaultValue: []) as List;
    _todoList = data.map((item) {
      final map = Map<String, dynamic>.from(item);
      return Todo(
        id: map["id"],
        title: map["title"],
        isDone: map["isDone"],
        createAt: map["createAt"],
        deadline: map["deadline"],
      );
    }).toList();
    return _todoList;
  }
}