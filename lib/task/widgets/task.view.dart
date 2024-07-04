import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';
import 'package:model_house/task/widgets/assigned_task.list_view.dart';

class TaskView extends StatelessWidget {
  const TaskView({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${task.title}"),
            Text("Description: ${task.description}"),
            Expanded(
              child: AssignedTaskListView(
                taskId: task.id,
              ),
            ),
            const SizedBox(height: 24),
            SafeArea(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Assign"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
