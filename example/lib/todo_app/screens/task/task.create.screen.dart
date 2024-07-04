import 'package:example/todo_app/screens/task/widgets/assign.user.list.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/model_house.dart';
import 'package:model_house/task/widgets/task.view.screen.dart';

class TaskCreateScreen extends StatefulWidget {
  static const String routeName = '/TaskCreate';
  const TaskCreateScreen({super.key});

  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final title = TextEditingController();
  final description = TextEditingController();

  String get myUid => FirebaseAuth.instance.currentUser!.uid;

  List<String> uids = [];

  List<String> assignedUids = [];

  @override
  void initState() {
    super.initState();
    uids.add(myUid);
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              controller: title,
            ),
            spaceMd,
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              controller: description,
            ),
            spaceMd,
            spaceMd,
            const Text("Assign to:"),
            Expanded(
              child: uids.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${uids[index]}${uids[index] == myUid ? " (You)" : ""}",
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      uids.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            if (index == uids.length - 1) ...[
                              ElevatedButton(
                                onPressed: () {
                                  showAssignUserListScreen(context);
                                },
                                child: const Text("+ Add Assigned User"),
                              )
                            ]
                          ],
                        );
                      },
                      itemCount: uids.length,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showAssignUserListScreen(context);
                          },
                          child: const Text("+ Add Assigned User"),
                        ),
                      ],
                    ),
            ),
            SafeArea(
              child: ElevatedButton(
                onPressed: () async {
                  final task = await Task.create(
                    title: title.text,
                    description: description.text,
                    assignedUids: uids,
                  );
                  if (!context.mounted) return;
                  context.pop();
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (context, a1, a2) {
                      return TaskViewScreen(
                        task: task,
                      );
                    },
                  );
                },
                child: const Text("Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAssignUserListScreen(BuildContext context) async {
    final re = await showGeneralDialog<String?>(
      context: context,
      pageBuilder: (context, a1, a2) {
        return const AssignUserListScreen();
      },
    );
    if (re == null || uids.contains(re)) return;
    setState(() => uids.add(re));
  }
}
