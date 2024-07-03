import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:model_house/task/task.dart';
import 'package:model_house/task/widgets/task.tile.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    this.itemBuilder,
    // TODO the fields from Firestore List View
  });

  final Widget Function(BuildContext context, Task task)? itemBuilder;

  // TODO this.query or Task.col
  Query<Object?> get _query => Task.col;

  @override
  Widget build(BuildContext context) {
    // TODO make it a FirestoreQueryBuilder
    return FirestoreListView(
      query: _query,
      itemBuilder: (context, doc) {
        final task = Task.fromSnapshot(doc);
        return itemBuilder?.call(context, task) ?? TaskTile(task: task);
      },
    );
  }
}
