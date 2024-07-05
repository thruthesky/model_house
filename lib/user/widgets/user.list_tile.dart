import 'package:flutter/material.dart';
import 'package:model_house/user/user.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user.displayName,
      ),
    );
  }
}
