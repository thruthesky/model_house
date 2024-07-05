import 'package:example/firebase_options.dart';
import 'package:example/todo_app/todo_app.router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';
import 'package:model_house/translation/translation.service.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TranslationService.instance.init(
    deviceLocale: true,
    defaultLocale: 'ko',
    fallbackLocale: 'en',
    useKeyAsDefaultText: false,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  UserService.instance.init();
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: todoRouter,
    );
  }
}
