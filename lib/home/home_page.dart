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
    if (state.status == HomeStatus.empty) {
      return const Center(child: Text('Задач пока нет'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.todoList.length,
      itemBuilder: (context, index) {
        final todo = state.todoList[index];
        return Card(
          
          
          surfaceTintColor: Colors.transparent,
          
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TodoDetailsPage(todo: todo),
                ),
              );
              _homeCubit.getTodoList();
            },
            leading: const Icon(
              Icons.check_box_outline_blank,
              color: Colors.grey,
            ),
            title: Text(todo.title),
          ),
        );
      },
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