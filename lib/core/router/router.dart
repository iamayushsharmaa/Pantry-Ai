import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_routes.dart';
import '../../features/favorites/presentation/favorite_routes.dart';
import '../../features/home/presentation/shell_routes.dart';
import '../../features/preference/presentation/preference_routes.dart';
import '../../features/save_recipe/presentation/saved_routes.dart';
import '../../features/scan/presentation/scan_route.dart';
import 'app_routes.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      ...authRoutes,
      ...recipeRoutes,
      ...scanRoutes,
      ...tasteRoutes,
      ...favoriteRoutes,
      ...savedRoutes,
      shellRoute,
    ],
    errorBuilder: (_, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
