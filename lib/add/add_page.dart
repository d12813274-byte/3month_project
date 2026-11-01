import 'package:flutter/material.dart';
import 'package:flutter_month3/main.dart';
import 'package:flutter_month3/database/todo.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _controller = TextEditingController();
void _onSaveTap() {
  final text = _controller.text.trim();
       if (text.isEmpty) return;

  final now = DateTime.now();
  
  
  appRepository.addTodo(
    Todo(
      id: now.millisecondsSinceEpoch,
       title: text,
        isDone: false,
      createAt: "${now.day}.${now.month}.${now.year}",
      deadline: "",
    ),
  );
  Navigator.of(context).pop();
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая задача'),
        centerTitle: true,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Название задачи'),
              const SizedBox(height: 8),
              TextField(
                controller: _controller,
          decoration: InputDecoration(
           hintText: 'Введите название задачи',
               filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _onSaveTap,
                  child: const Text('Сохранить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }





}


