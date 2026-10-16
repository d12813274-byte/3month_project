import 'package:flutter/material.dart';
import 'package:flutter_month3/add/add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> tasks = [];

  Future<void> _onAddTap() async {
    final result = await Navigator.of(
      context,
    ).push<String>(MaterialPageRoute(builder: (_) => const AddPage()));
    if (result != null && result.isNotEmpty) {
      setState(() {
        tasks.insert(0, result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мои задачи',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('Задач пока нет'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
                    title: Text(tasks[index]),
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
