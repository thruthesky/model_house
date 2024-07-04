import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class UserHomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserHome'),
      ),
      body: Column(
        children: [
          AuthStateChanges(
            builder: (user) => user == null
                ? const EmailPasswordLogin()
                : ElevatedButton(
                    onPressed: () => i.signOut(),
                    child: const Text('Logout'),
                  ),
          ),
          MyDoc(
            builder: (user) => user == null
                ? const SizedBox.shrink()
                : Text('Welcome ${user.updatedAt}'),
          ),
        ],
      ),
    );
  }
}
