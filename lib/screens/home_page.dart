import 'package:flutter/material.dart';
import '../db/db.dart';
import '../models/todo.dart';
import '../widgets/input_row.dart';
import '../widgets/todo_list.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = Db.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          InputRow(onAdd: addItem),
          TodoList(onAdd: addItem),
        ],
      ),
    );
  }

  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }
}