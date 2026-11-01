import 'package:flutter_month3/database/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDatabase {
  final Box box = Hive.box("todoBox");
  List<Todo> _todoList = [];

  AppDatabase() {
  getTodoList();
}
void updateTodo(int id, String title, String deadline) {
  for (final todo in _todoList) {
    if (todo.id == id){
      todo.title = title;
      todo.deadline = deadline;
    }
  }
  saveTodos();
}

void deleteTodo(int id) {
  _todoList.removeWhere((todo) => todo.id == id);
  saveTodos();
}

void addTodo(Todo todo) {
  _todoList.insert(0, todo);
  saveTodos();
}
  

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