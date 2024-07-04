import 'package:example/todo_app/screens/task/task.create.screen.dart';
import 'package:example/todo_app/screens/task/task.list.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/user/user.defines.dart';
import 'package:model_house/user/widgets/auth_state_changes.dart';
import 'package:model_house/user/widgets/display_name.dart';
import 'package:model_house/widgets/auth/email_password_login.dart';

class TodoHomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
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
                          context.push(TaskCreateScreen.routeName);
                        },
                        child: const Text('Create Task'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.push(TaskListScreen.routeName);
                        },
                        child: const Text('Task List'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.push(TaskListScreen.routeName);
                        },
                        child: const Text('Assigned List'),
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
