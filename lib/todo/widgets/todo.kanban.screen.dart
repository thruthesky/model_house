import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:model_house/todo/todo.dart';
import 'package:model_house/todo/widgets/todo.list.tile.dart';

class TodoKanbanScreen extends StatefulWidget {
  const TodoKanbanScreen({super.key});

  @override
  State<TodoKanbanScreen> createState() => _TodoKanbanScreenState();
}

class _TodoKanbanScreenState extends State<TodoKanbanScreen> {
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text("TODO"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FirestoreListView(
                            query: Todo.col.where(
                              'status',
                              isEqualTo: Status.todo.name,
                            ),
                            itemBuilder: (context, doc) {
                              final todo = Todo.fromSnapshot(doc);
                              return TodoListTile(todo: todo);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text("ONGOING"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FirestoreListView(
                            query: Todo.col.where(
                              'status',
                              isEqualTo: Status.ongoing.name,
                            ),
                            itemBuilder: (context, doc) {
                              final todo = Todo.fromSnapshot(doc);
                              return TodoListTile(todo: todo);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text("DONE"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FirestoreListView(
                            query: Todo.col.where(
                              'status',
                              isEqualTo: Status.done.name,
                            ),
                            itemBuilder: (context, doc) {
                              final todo = Todo.fromSnapshot(doc);
                              return TodoListTile(todo: todo);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
