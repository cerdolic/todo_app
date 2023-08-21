import 'package:flutter/material.dart';
import '../models/todo.dart';

class InputRow extends StatelessWidget {
  final textController = TextEditingController();
  final Function onAdd;

  InputRow({required this.onAdd, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Add note',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: textController,
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: value.text.isNotEmpty
                    ? () {
                        var todo = Todo(
                          title: textController.text,
                          creationDate: DateTime.now(),
                          isChecked: false,
                        );
                        onAdd(todo);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 12.0,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
