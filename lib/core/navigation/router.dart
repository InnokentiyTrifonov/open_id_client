import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_id/presentation/pages/authentification_screen.dart';
import 'package:open_id/presentation/pages/home_page.dart';
import 'package:open_id/presentation/pages/splash.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const Splash();
      },
    ),
    GoRoute(
      path: '/login_page',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthentificationScreen();
      },
    ),
    GoRoute(
      path: '/home_page',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
  ],
);
