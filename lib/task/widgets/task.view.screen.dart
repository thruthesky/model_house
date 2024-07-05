import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';
import 'package:model_house/task/widgets/assigned_task.list_view.dart';

class TaskViewScreen extends StatelessWidget {
  const TaskViewScreen({
    super.key,
    required this.task,
  });

  final Task task;

  Widget get space => const SizedBox(height: 12);

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
            space,
            Text("Description: ${task.description}"),
            space,
            const Text("Assigned to:"),
            // Expanded(
            //   child: AssignedTaskListView(
            //     taskId: task.id,
            //   ),
            // ),
            space,
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
