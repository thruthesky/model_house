import 'package:example/todo_app/screens/task/task.create.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/model_house.dart';
import 'package:model_house/task/widgets/task.list_tile.dart';

class TaskListScreen extends StatefulWidget {
  static const String routeName = '/TaskList';
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _title.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskListView(
                itemBuilder: (context, task) {
                  return Row(
                    children: [
                      Expanded(
                        child: TaskListTile(
                          task: task,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  context.push(TaskCreateScreen.routeName);
                },
                child: const Text('Add Task'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
