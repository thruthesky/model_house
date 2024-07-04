import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:model_house/task/assigned_task.dart';
import 'package:model_house/task/widgets/assigned_task.list_tile.dart';

class AssigneeListView extends StatelessWidget {
  const AssigneeListView({
    super.key,
    required this.taskId,
    this.itemBuilder,
  });

  final String taskId;
  final Widget Function(BuildContext context, AssignedTask task)? itemBuilder;

  Query<Object?> get query => AssignedTask.subCol(taskId);

  @override
  Widget build(BuildContext context) {
    // TODO make it a FirestoreQueryBuilder
    return FirestoreListView(
      query: query,
      itemBuilder: (context, doc) {
        // final task = Task.fromSnapshot(doc);
        // return itemBuilder?.call(context, task) ?? TaskTile(task: task);

        final assignedTask = AssignedTask.fromSnapshot(doc);
        return AssignedTaskListTile(
          assignedTask: assignedTask,
        );
      },
    );
  }
}
