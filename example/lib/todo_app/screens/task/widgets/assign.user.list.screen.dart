import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This will be deleted since user List View is not ready yet.
class AssignUserListScreen extends StatelessWidget {
  const AssignUserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign User List'),
      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance.collection('users'),
        itemBuilder: (context, doc) {
          final userData = doc.data();
          return ListTile(
            title: Text(doc.id),
            subtitle: Text(userData['name'] ?? 'No name'),
            onTap: () {
              context.pop(doc.id);
            },
          );
        },
      ),
    );
  }
}
