import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

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
              child: ListView.builder(
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
                          onPressed: () {},
                          child: const Text("+ Add Assigned User"),
                        )
                      ]
                    ],
                  );
                },
                itemCount: uids.length,
              ),
            ),
            SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  Task.create(
                    title: title.text,
                    description: description.text,
                  );

                  // TODO pop
                  // TODO push view screen
                },
                child: const Text("Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
