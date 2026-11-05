import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month3/main.dart';

class TodoDetailsCubit extends Cubit<void> {
  TodoDetailsCubit() : super(null);

  void deleteTodo(int id) {
    appRepository.deleteTodo(id);
  }

void updateTodo(int id, String title, String deadline) {
  final text = title.trim();

  if (text.isEmpty) {
    throw Exception("Название задачи не может быть пустым");
  }
  if (text.length < 4) {
    throw Exception("Название должно содержать минимум 4 символа");
  }

  appRepository.updateTodo(id, text, deadline);
}
}