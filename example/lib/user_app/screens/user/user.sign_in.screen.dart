import 'package:flutter/material.dart';

class UserSignInScreen extends StatefulWidget {
  static const String routeName = '/UserSignIn';
  const UserSignInScreen({super.key});

  @override
  State<UserSignInScreen> createState() => _UserSignInScreenState();
}

class _UserSignInScreenState extends State<UserSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserSignIn'),
      ),
      body: const Column(
        children: [
          Text("UserSignIn"),
        ],
      ),
    );
  }
}
