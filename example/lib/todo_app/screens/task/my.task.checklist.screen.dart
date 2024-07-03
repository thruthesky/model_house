import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';
import 'package:model_house/task/widgets/task.tile.dart';

class MyTaskChecklistScreen extends StatefulWidget {
  static const String routeName = '/TodoList';
  const MyTaskChecklistScreen({super.key});

  @override
  State<MyTaskChecklistScreen> createState() => _MyTaskChecklistScreenState();
}

class _MyTaskChecklistScreenState extends State<MyTaskChecklistScreen> {
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
        title: const Text('Todo Check List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskListView(
                itemBuilder: (context, task) {
                  return Row(
                    children: [
                      Expanded(
                        child: TaskTile(
                          task: task,
                        ),
                      ),
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          if (value == true) {
                            task.updateStatus(TaskStatus.done);
                          } else if (value == false) {
                            task.updateStatus(TaskStatus.todo);
                          }
                        },
                      ),
                    ],
                  );
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
    // TODO must come from correct source
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await Task.create(
      title: _title.text,
      creatorUid: uid,
      assigned: {
        uid: TaskStatus.todo,
      },
    );
    _title.clear();
  }
}
