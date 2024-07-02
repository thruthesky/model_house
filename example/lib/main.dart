import 'package:example/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';
import 'package:model_house/todo/widgets/todo.screen.dart';
import 'package:model_house/widgets/auth/email_password_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TranslationService.instance.init(
    deviceLocale: true,
    defaultLocale: 'ko',
    fallbackLocale: 'en',
    useKeyAsDefaultText: false,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    UserService.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('house.name'.t),
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
                        onPressed: () => i.signOut(),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
          ),
          ElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TodoScreen(),
            ),
            child: const Text("TODOs"),
          ),
          ElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HouseHomeScreen(),
            ),
            child: const Text("House with Friendship"),
          ),
          ElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HouseHomeScreen(),
            ),
            child: const Text("House with Friendship, Chat"),
          ),
        ],
      ),
    );
  }
}
