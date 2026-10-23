import 'package:flutter/material.dart';
import 'package:flutter_month3/add/add_page.dart';
import 'package:flutter_month3/settings/settings_page.dart';
import 'package:flutter_month3/database/app_database.dart';
import 'package:flutter_month3/database/todo.dart';
import 'package:flutter_month3/details/todo_details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month3/settings/settings_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final  AppDatabase _appDatabase = AppDatabase();
   List<Todo> _todoList = [];
   @override
  void initState() {
    super.initState();
    _todoList = _appDatabase.getTodoList();
  }

  Future<void> _onAddTap() async {
    final result = await Navigator.of(
      context,
    ).push<String>(MaterialPageRoute(builder: (_) => const AddPage()));
    
  }

  void _onSettingsTap() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => BlocProvider(create: (_) => SettingsCubit (), 
    child: const SettingsPage(),
       )
      
      ),
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
      body: _todoList.isEmpty
          ? const Center(child: Text('Задач пока нет'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => TodoDetailsPage(todo: _todoList[index],)));
                    },
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
                    title: Text(_todoList[index].title),
                  ),
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