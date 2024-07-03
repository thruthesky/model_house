import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_house/task/task.dart';

// TODO review.
// @withcenter.dev2:
// I am thinking on deleting this.
// But I need to review if some sort of basic
// default widget is needed.
class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    this.buider,
    this.onTap,
  });

  final Task task;

  final Widget Function(
    BuildContext context,
    Task task,
  )? buider;

  final Function(
    BuildContext context,
    Task task,
  )? onTap;

  @override
  Widget build(BuildContext context) {
    return buider?.call(context, task) ??
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: ListTile(
            title: Text(task.title ?? ""),
            subtitle: Text(task.status?.name ?? ""),
            onTap: () => _onTap(context),
          ),
        );
  }

  _onTap(BuildContext context) {
    if (onTap != null) {
      onTap!(context, task);
      return;
    }
    setStatus(context);
  }

  setStatus(BuildContext context) async {
    final status = await showDialog<TaskStatus?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Set Status"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              title: const Text("TODO"),
              onTap: () => Navigator.pop(context, TaskStatus.todo),
            ),
            ListTile(
              title: const Text("ONGOING"),
              onTap: () => Navigator.pop(context, TaskStatus.ongoing),
            ),
            if (task.creatorUid == FirebaseAuth.instance.currentUser?.uid)
              ListTile(
                title: const Text("COMPLETED"),
                onTap: () => Navigator.pop(context, TaskStatus.done),
              )
            else
              ListTile(
                title: const Text("REVIEW"),
                onTap: () => Navigator.pop(context, TaskStatus.review),
              ),
          ]),
        );
      },
    );
    if (status == null) return;
    await task.updateStatus(status);
  }
}
