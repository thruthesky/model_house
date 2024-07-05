import 'package:example/user_app/screens/home/user.home.screen.dart';
import 'package:example/user_app/screens/user/user.sign_in.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/model_house.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// GoRouter
final userRouter = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    GoRoute(
      path: UserHomeScreen.routeName,
      builder: (context, state) => const UserHomeScreen(),
    ),
    GoRoute(
      path: UserSignInScreen.routeName,
      builder: (context, state) => const UserSignInScreen(),
    ),
    GoRoute(
      path: UserProfileUpdateScreen.routeName,
      builder: (context, state) => const UserProfileUpdateScreen(),
    ),
  ],
);
