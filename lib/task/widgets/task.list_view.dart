import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:model_house/task/task.dart';
import 'package:model_house/task/widgets/task.list_tile.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    this.itemBuilder,
    // TODO the fields from Firestore List View
  });

  final Widget Function(BuildContext context, Task task)? itemBuilder;

  String get myUid => FirebaseAuth.instance.currentUser!.uid;

  Query<Object?> get query => Task.col.where('creatorUid', isEqualTo: myUid);

  @override
  Widget build(BuildContext context) {
    // TODO make it a FirestoreQueryBuilder
    return FirestoreListView(
      query: query,
      itemBuilder: (context, doc) {
        final task = Task.fromSnapshot(doc);
        return itemBuilder?.call(context, task) ?? TaskListTile(task: task);
      },
    );
  }
}
