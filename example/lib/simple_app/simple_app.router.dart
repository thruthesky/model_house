import 'package:example/simple_app/screens/home/simple.home.screen.dart';
import 'package:example/simple_app/screens/menu/simple.menu.screen.dart';
import 'package:example/simple_app/screens/user/simple.sign_in.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// GoRouter
final simpleRouter = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    GoRoute(
      path: SimpleHomeScreen.routeName,
      builder: (context, state) => const SimpleHomeScreen(),
    ),
    GoRoute(
      path: SimpleSignInScreen.routeName,
      builder: (context, state) => const SimpleSignInScreen(),
    ),
    GoRoute(
      path: SimpleMenuScreen.routeName,
      builder: (context, state) => const SimpleMenuScreen(),
    ),
  ],
);
