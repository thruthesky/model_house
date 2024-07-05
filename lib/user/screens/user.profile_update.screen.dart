import 'package:date_picker_v2/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class UserProfileUpdateScreen extends StatefulWidget {
  static const String routeName = '/UserProfileUpdate';
  const UserProfileUpdateScreen({super.key});

  @override
  State<UserProfileUpdateScreen> createState() =>
      _UserProfileUpdateScreenState();
}

class _UserProfileUpdateScreenState extends State<UserProfileUpdateScreen> {
  final displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    displayNameController.text = my?.displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Column(
        children: [
          LabelField(label: 'displayName'.t, controller: displayNameController),
          const SizedBox(height: 24),
          DatePicker(onChanged: (year, month, day) {
            // print('$year-$month-$day');
          }),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              my?.update(
                displayName: displayNameController.text,
                // birthYear: birthYear,
                // birthMonth: birthMonth,
                // birthDay: birthDay,
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
