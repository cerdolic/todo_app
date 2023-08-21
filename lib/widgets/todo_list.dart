import 'package:flutter/material.dart';
import '../db/db.dart';
import '../widgets/todo_card.dart';

class TodoList extends StatefulWidget {
  final Function onAdd;

  const TodoList(
      {required this.onAdd, Key? key})
      : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final db = Db.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getTodoList(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var itemCount = data?.length ?? 0;
          return data == null || itemCount == 0
              ? const Center(
                  child: Text('Your TODO list is empty.'),
                )
              : ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, i) => Dismissible(
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      db.deleteTodo(data[i]);
                      setState(() {
                        data.removeAt(i);
                      });
                    },
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: TodoCard(
                      id: data[i].id,
                      title: data[i].title,
                      creationDate: data[i].creationDate,
                      isChecked: data[i].isChecked,
                      onChanged: widget.onAdd,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
