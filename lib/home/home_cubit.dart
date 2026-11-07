import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month3/database/todo.dart';
import 'package:flutter_month3/home/home_state.dart';
import 'package:flutter_month3/main.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(const HomeState(todoList: [], status: HomeStatus.isLoading));

  void getTodoList() {
    final List<Todo> todoList = appRepository.getTodoList();

    if (todoList.isEmpty) {
      emit(state.copyWith(todoList: [], status: HomeStatus.empty));
    } else {
      emit(state.copyWith(todoList: todoList, status: HomeStatus.success));
    }
  }

  void toggleTodo(int id) {
    appRepository.toggleTodo(id);
    getTodoList();
  }
}