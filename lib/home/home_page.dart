import 'package:flutter/material.dart';
import 'package:flutter_month3/add/add_page.dart';
import 'package:flutter_month3/settings/settings_page.dart';

import 'package:flutter_month3/details/todo_details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month3/home/home_cubit.dart';
import 'package:flutter_month3/home/home_state.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeCubit _homeCubit = HomeCubit();

  @override
  void initState() {
    super.initState();
    _homeCubit.getTodoList();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  Future<void> _onAddTap() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AddPage()),
    );
    _homeCubit.getTodoList();
  }

  void _onSettingsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _onSettingsTap,
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: _homeCubit,
        builder: (context, state) {
          final total = state.todoList.length;
          final done = state.todoList.where((t) => t.isDone).length;
          final progress = total == 0 ? 0.0 : done / total;

          return Column(
            children: [
              // Блок "Сегодня"
              Card(
                surfaceTintColor: Colors.transparent,
                elevation: 3,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Сегодня',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$done из $total выполнено',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            color: const Color(0xFF007AFF),
                            backgroundColor: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Список задач',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
              Expanded(
                child: state.status == HomeStatus.empty
                    ? const Center(child: Text('Задач пока нет'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.todoList.length,
                        itemBuilder: (context, index) {
                          final todo = state.todoList[index];
                          final date = todo.deadline.isNotEmpty
                              ? todo.deadline
                              : todo.createAt;
                          return Card(
                            surfaceTintColor: Colors.transparent,
                            elevation: 3,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            child: ListTile(
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => TodoDetailsPage(todo: todo),
                                  ),
                                );
                                _homeCubit.getTodoList();
                              },
                              leading: Checkbox(
                                value: todo.isDone,
                                activeColor: const Color(0xFF007AFF),
                                onChanged: (_) {
                                  _homeCubit.toggleTodo(todo.id);
                                },
                              ),
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  decoration: todo.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: todo.isDone ? Colors.grey : null,
                                ),
                              ),
                              subtitle: Text(date),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTap,
        backgroundColor: const Color(0xFF007AFF),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}