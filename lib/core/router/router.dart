import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/recipe_routes.dart';

import '../../features/auth/presentation/auth_routes.dart';
import '../../features/home/presentation/shell_routes.dart';
import '../../features/preference/presentation/preference_routes.dart';
import '../../features/recipe_detail/presentation/detail_routes.dart';
import '../../features/scan/presentation/scan_route.dart';
import '../../features/settings/presentation/edit_profile_route.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    ...authRoutes,
    ...scanRoutes,
    ...tasteRoutes,
    ...recipeRoutes,
    ...detailRecipeRoutes,
    ...editProfileRoutes,
    shellRoute,
  ],
  errorBuilder: (_, state) =>
      Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
);
