import 'package:flutter_month3/database/app_database.dart';
import 'package:flutter_month3/database/todo.dart';

abstract class AppRepository {
  List<Todo> getTodoList();
  void addTodo(Todo todo);
  void updateTodo(int id, String title, String deadline);
  void deleteTodo(int id);
}

class AppRepositoryImpl implements AppRepository {
  final AppDatabase db;

  AppRepositoryImpl({required this.db});

  @override
  List<Todo> getTodoList() {
    return db.getTodoList();
  }

  @override
  void addTodo(Todo todo) {
    db.addTodo(todo);
  }

  @override
  void updateTodo(int id, String title, String deadline) {
    db.updateTodo(id, title, deadline);
  }

  @override
  void deleteTodo(int id) {
    db.deleteTodo(id);
  }
}