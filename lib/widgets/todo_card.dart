import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';

class TodoCard extends StatefulWidget {
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;
  final Function onChanged;
  TodoCard(
      {required this.id,
        required this.title,
        required this.creationDate,
        required this.isChecked,
        required this.onChanged,
        Key? key})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Checkbox(
              value: widget.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.isChecked = value!;
                });
                var updatedTodo = Todo(
                    id: widget.id,
                    title: widget.title,
                    creationDate: widget.creationDate,
                    isChecked: value!);
                widget.onChanged(updatedTodo);
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('dd MMM yyyy - hh:mm aaa')
                      .format(widget.creationDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8F8F8F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}