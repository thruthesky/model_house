import 'package:flutter/material.dart';

class TaskCreateScreen extends StatefulWidget {
  static const String routeName = '/TodoCreate';
  const TaskCreateScreen({super.key});

  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  // List<String> urls = [];

  List<String> assignedUids = [];

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Widget get spaceMd => const SizedBox(height: 12.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              controller: _title,
            ),
            spaceMd,
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              controller: _description,
            ),
            spaceMd,
            ElevatedButton(
              onPressed: () {},
              child: const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
