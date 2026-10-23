import 'package:flutter/material.dart';
import 'package:flutter_month3/database/todo.dart';


class TodoDetailsPage extends StatefulWidget {
  const TodoDetailsPage({super.key, required this.todo,});
  final Todo todo;

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage>{
  final TextEditingController _controller = TextEditingController();
@override 
void initState() {
  super.initState();
  _controller.text = widget.todo.title;
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
        title: Text("Редактировать задачу"),
        centerTitle: true,
        actions: [IconButton(
          onPressed: () {}, 
        icon: Icon(Icons.delete, color: Colors.red,)),]
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child:  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text("Название задачи"), 
        SizedBox(height: 8,),
        TextField(controller: _controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF2F2F7),
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
        decoration: BoxDecoration(color: Color(0xFFF2F2F7), borderRadius: 
        BorderRadius.circular(10)),
        child: Text("14 сентября 2026"),
        ),
        Spacer(),
        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: () {}, 
          child: Text("Сохранить измения"),
          ),
          ),
        ],
      ),
      ),
    );
  }

}