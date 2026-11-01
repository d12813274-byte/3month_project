import 'package:flutter/material.dart';
import 'package:flutter_month3/database/todo.dart';
import 'package:flutter_month3/details/todo_details_cubit.dart';


class TodoDetailsPage extends StatefulWidget {
  const TodoDetailsPage({super.key, required this.todo,});
  final Todo todo;

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage>{
  final TextEditingController _controller = TextEditingController();
  final TodoDetailsCubit _cubit = TodoDetailsCubit();
@override 
void initState() {
  super.initState();
  _controller.text = widget.todo.title;
}
@override
void dispose() {
  _controller.dispose();
  _cubit.close();
  super.dispose();
}
void _onDeleteTap() {
  _cubit.deleteTodo(widget.todo.id);
  Navigator.of(context).pop();
}
void _onSaveTap() {
  final title = _controller.text.trim();
  if (title.isEmpty) return;

  _cubit.updateTodo(widget.todo.id, title, widget.todo.deadline);
  Navigator.of(context).pop();
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Редактировать задачу"),
        centerTitle: true,
        actions: [IconButton(
          onPressed: _onDeleteTap, 
        icon: Icon(Icons.delete, color: Colors.red,)),]
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child:  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text("Название задачи"), 
        SizedBox(height: 8,),
        TextField(controller: _controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )
        ),
        ), 
        SizedBox(height: 16), 
        Text("Дата выполнения"),
        SizedBox(height: 8), 
        Container(width: double.infinity, padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: 
        BorderRadius.circular(10)),
        child: Text("14 сентября 2026"),
        ),
        Spacer(),
        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: _onSaveTap, 
          child: Text("Сохранить измения"),
          ),
          ),
        ],
      ),
      ),
    );
  }

}