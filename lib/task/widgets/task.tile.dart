import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_house/task/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: ListTile(
        title: Text(task.title ?? ""),
        subtitle: Text(task.status.name),
        onTap: () => setStatus(context),
      ),
    );
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
                onTap: () => Navigator.pop(context, TaskStatus.completed),
              )
            else
              ListTile(
                title: const Text("COMPLETED"),
                onTap: () => Navigator.pop(context, TaskStatus.completed),
              ),
          ]),
        );
      },
    );
    if (status == null) return;
    await task.update(status: status);
  }
}
