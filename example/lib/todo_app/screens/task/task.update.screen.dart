import 'package:flutter/material.dart';

class TodoUpdateScreen extends StatefulWidget {
  static const String routeName = '/TodoUpdate';
  const TodoUpdateScreen({super.key});

  @override
  State<TodoUpdateScreen> createState() => _TodoUpdateScreenState();
}

class _TodoUpdateScreenState extends State<TodoUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoUpdate'),
      ),
      body: const Column(
        children: [
          Text("TodoUpdate"),
        ],
      ),
    );
  }
}
