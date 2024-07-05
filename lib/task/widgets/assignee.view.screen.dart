import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_house/task/assigned_task.dart';

class AssigneeViewScreen extends StatefulWidget {
  const AssigneeViewScreen({
    super.key,
    required this.assignedTask,
  });

  final Assignee assignedTask;

  @override
  State<AssigneeViewScreen> createState() => _AssigneeViewScreenState();
}

class _AssigneeViewScreenState extends State<AssigneeViewScreen> {
  String get myUid => FirebaseAuth.instance.currentUser!.uid;

  Widget get spaceMd => const SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Assignee: ${widget.assignedTask.assigneeUid}"),
            Text("Status: ${widget.assignedTask.status}"),
            spaceMd,
            if (widget.assignedTask.assigneeUid == myUid)
              ElevatedButton(
                onPressed: () {
                  changeStatus(context);
                },
                child: const Text("Change Status"),
              ),
          ],
        ),
      ),
    );
  }

  changeStatus(BuildContext context) async {
    final re = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if ([AssigneeStatus.todo, AssigneeStatus.paused].contains(
                widget.assignedTask.status,
              )) ...[
                ListTile(
                  title: const Text("Begin/Continue Doing it"),
                  subtitle: const Text("Set as ONGOING"),
                  onTap: () async {
                    await widget.assignedTask
                        .update(status: AssigneeStatus.ongoing);
                    if (!context.mounted) return;
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                ),
              ],
              if (widget.assignedTask.status == AssigneeStatus.ongoing) ...[
                const ListTile(
                  title: Text("Pause it"),
                  subtitle: Text("Set as PAUSED"),
                ),
              ],
              ListTile(
                title: const Text("Set as Completed"),
                subtitle: Text(
                  widget.assignedTask.assigneeUid ==
                              widget.assignedTask.assignerUid &&
                          widget.assignedTask.assignerUid == myUid
                      ? "Set as DONE"
                      : "Send for review",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
