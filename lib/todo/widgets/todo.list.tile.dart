import 'package:flutter/material.dart';
import 'package:model_house/todo/todo.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    required this.todo,
  });

  final Todo todo;

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
        subtitle: Text(todo.status.name),
        onTap: () => _setStatus(context),
      ),
    );
  }

  _setStatus(BuildContext context) async {
    final status = await showDialog<Status?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Set Status"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              title: const Text("TODO"),
              onTap: () => Navigator.pop(context, Status.todo),
            ),
            ListTile(
              title: const Text("ONGOING"),
              onTap: () => Navigator.pop(context, Status.ongoing),
            ),
            ListTile(
              title: const Text("DONE"),
              onTap: () => Navigator.pop(context, Status.done),
            ),
          ]),
        );
      },
    );
    if (status == null) return;
    await todo.updateStatus(status);
  }
}
