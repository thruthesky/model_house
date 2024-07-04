import 'package:flutter/material.dart';
import 'package:model_house/task/task.dart';
import 'package:model_house/task/widgets/task.view.dart';

// TODO review.
// @withcenter.dev2:
// I am thinking on deleting this.
// But I need to review if some sort of basic
// default widget is needed.
class TaskListTile extends StatelessWidget {
  const TaskListTile({
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
            // subtitle: Text(task.status?.name ?? ""),
            onTap: () => _onTap(context),
          ),
        );
  }

  _onTap(BuildContext context) {
    if (onTap != null) {
      onTap!(context, task);
      return;
    }
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a1, a2) {
        return TaskView(
          task: task,
        );
      },
    );
  }
}
