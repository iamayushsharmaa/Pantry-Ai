import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:pantry_ai/features/home/presentation/screens/widget_tree.dart';
import 'package:pantry_ai/splash.dart';

import '../features/analytics/presentation/screens/analytics_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/recipe_suggestions/presentation/screens/dishes_detail_screen.dart';
import '../features/recipe_suggestions/presentation/screens/dishes_list_screen.dart';
import '../features/scan/presentation/screens/scan_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

GoRouter createRouter() {
  final initialLocation = '/onboarding';

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onBoarding',
        builder: (context, state) => OnBoardingScreen(),
      ),

      GoRoute(
        path: '/sign-in',
        name: 'signIn',
        builder: (context, state) => SigninScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        name: 'signUp',
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: '/recipe_suggestions-detail',
        name: 'dishesDetail',
        builder: (context, state) => DishesDetailScreen(),
      ),
      GoRoute(
        path: '/recipe_suggestions-list',
        name: 'dishesList',
        builder: (context, state) => DishesListScreen(),
      ),
      GoRoute(
        path: '/scan',
        name: 'scan',
        builder: (context, state) => ScanScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => WidgetTree(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: '/analytics',
            name: 'analytics',
            builder: (context, state) => AnalyticsScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
