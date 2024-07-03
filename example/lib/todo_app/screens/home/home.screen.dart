import 'package:example/todo_app/screens/todo/todo.list.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/user/user.defines.dart';
import 'package:model_house/user/widgets/auth_state_changes.dart';
import 'package:model_house/user/widgets/display_name.dart';
import 'package:model_house/widgets/auth/email_password_login.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          //
          iam.signedIn
              ? const Text('Yes, sign in !!')
              : const Text('Not signed In'),
          AuthStateChanges(
            builder: (user) => user == null
                ? const EmailPasswordLogin()
                : Column(
                    children: [
                      Text(user.uid),
                      DisplayName(
                        uid: user.uid,
                        initialData: user.displayName,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.push(TodoListScreen.routeName);
                        },
                        child: const Text('TODO CheckList'),
                      ),
                      ElevatedButton(
                        onPressed: () => i.signOut(),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
