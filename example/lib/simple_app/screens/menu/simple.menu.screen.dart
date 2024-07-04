import 'package:flutter/material.dart';

class SimpleMenuScreen extends StatefulWidget {
  static const String routeName = '/SimpleMenu';
  const SimpleMenuScreen({super.key});

  @override
  State<SimpleMenuScreen> createState() => _SimpleMenuScreenState();
}

class _SimpleMenuScreenState extends State<SimpleMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpleMenu'),
      ),
      body: const Column(
        children: [
          Text("SimpleMenu"),
        ],
      ),
    );
  }
}
