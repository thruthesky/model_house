import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:model_house/todo/todo.dart';
import 'package:model_house/todo/widgets/todo.list.tile.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _title.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FirestoreListView(
                query: Todo.col,
                itemBuilder: (context, doc) {
                  final todo = Todo.fromSnapshot(doc);
                  return TodoListTile(todo: todo);
                },
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Create Todo List"),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
                        child: TextField(
                          controller: _title,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: _addTodo,
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _addTodo() async {
    await Todo.create(
      title: _title.text,
    );
    _title.clear();
  }
}
