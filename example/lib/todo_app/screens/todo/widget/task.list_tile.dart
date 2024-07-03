import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.todo,
  });

  final Task todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: ListTile(
        title: Text(todo.title ?? ""),
        subtitle: Text(todo.status?.name ?? ""),
        onTap: () => _setStatus(context),
      ),
    );
  }

  _setStatus(BuildContext context) async {
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
            ListTile(
              title: const Text("COMPLETED"),
              onTap: () => Navigator.pop(context, TaskStatus.done),
            ),
          ]),
        );
      },
    );
    if (status == null) return;
    // await todo.updateStatus(status);
  }
}
