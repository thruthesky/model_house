import 'package:flutter/material.dart';

class SimpleSignInScreen extends StatefulWidget {
  static const String routeName = '/SimpleSignIn';
  const SimpleSignInScreen({super.key});

  @override
  State<SimpleSignInScreen> createState() => _SimpleSignInScreenState();
}

class _SimpleSignInScreenState extends State<SimpleSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpleSignIn'),
      ),
      body: const Column(
        children: [
          Text("SimpleSignIn"),
        ],
      ),
    );
  }
}
