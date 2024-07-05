import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:model_house/task/assigned_task.dart';
import 'package:model_house/task/widgets/assignee.view.screen.dart';
import 'package:model_house/user/user.defines.dart';

class AssignedTaskListScreen extends StatefulWidget {
  static const routeName = '/AssignedTaskList';

  const AssignedTaskListScreen({super.key});

  @override
  State<AssignedTaskListScreen> createState() => _AssignedTaskListScreenState();
}

class _AssignedTaskListScreenState extends State<AssignedTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Task List'),
      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance
            .collectionGroup(Assignee.subcollectionName)
            .where('assigneeUid', isEqualTo: iam.user!.uid),
        itemBuilder: (context, doc) {
          // final userData = doc.data();
          final assignee = Assignee.fromSnapshot(doc);

          return Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(doc.id),
                  subtitle: Text("Status: ${assignee.status}"),
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, a1, a2) =>
                          AssigneeViewScreen(assignedTask: assignee),
                    );
                  },
                ),
              ),
              Checkbox(
                value: [AssigneeStatus.completed, AssigneeStatus.review]
                    .contains(assignee.status),
                onChanged: (isCheck) {
                  if (isCheck ?? false) {
                    assignee.update(status: AssigneeStatus.review);
                  } else {
                    assignee.update(status: AssigneeStatus.paused);
                  }

                  setState(() {});
                },
              )
            ],
          );
        },
      ),
    );
  }
}
