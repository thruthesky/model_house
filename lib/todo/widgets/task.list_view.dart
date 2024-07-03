import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:model_house/todo/task.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      query: Task.col,
      itemBuilder: (context, doc) {
        final todo = Task.fromSnapshot(doc);
        return Text("$todo");
        // return TodoListTile(todo: todo);
      },
    );
  }
}
