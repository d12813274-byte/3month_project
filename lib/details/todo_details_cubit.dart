import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month3/main.dart';

class TodoDetailsCubit extends Cubit<void> {
  TodoDetailsCubit() : super(null);

  void deleteTodo(int id) {
    appRepository.deleteTodo(id);
  }

  void updateTodo(int id, String title, String deadline) {
    appRepository.updateTodo(id, title, deadline);
  }
}