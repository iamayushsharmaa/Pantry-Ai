import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/home/presentation/screens/all_recipe_screen.dart';
import 'package:pantry_ai/features/home/presentation/screens/home_screen.dart';
import 'package:pantry_ai/features/home/presentation/screens/widget_tree.dart';

import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import '../../saved/presentation/screens/saved_recipe_screen.dart';
import '../../settings/presentation/screens/settings_screen.dart';

ShellRoute shellRoute = ShellRoute(
  builder: (_, __, child) => WidgetTree(child: child),
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRouteNames.home,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.saved,
      name: AppRouteNames.saved,
      builder: (_, __) => const SavedScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: AppRouteNames.settings,
      builder: (_, __) => const SettingsScreen(),
    ),
  ],
);
