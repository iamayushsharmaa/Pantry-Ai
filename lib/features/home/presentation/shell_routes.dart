import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/home/presentation/screens/all_recipe_screen.dart';
import 'package:pantry_ai/features/home/presentation/screens/home_screen.dart';
import 'package:pantry_ai/features/home/presentation/screens/widget_tree.dart';

import '../../../core/di/injections.dart';
import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import '../../analytics/presentation/bloc/analytics_bloc.dart';
import '../../analytics/presentation/screens/analytics_screen.dart';
import '../../settings/presentation/bloc/settings_bloc.dart';
import '../../settings/presentation/screens/settings_screen.dart';

ShellRoute shellRoute = ShellRoute(
  builder: (_, __, child) => WidgetTree(child: child),
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRouteNames.home,
      builder: (_, __) => HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.analytics,
      name: AppRouteNames.analytics,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AnalyticsBloc>()..add(LoadAnalytics()),
        child: const AnalyticsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: AppRouteNames.settings,
      builder: (_, __) => BlocProvider(
        create: (_) => SettingsBloc(
          updateNameUseCase: sl(),
          updateEmailUseCase: sl(),
          signOutUseCase: sl(),
          deleteAccountUseCase: sl(),
          initialUser: sl(),
        ),
        child: SettingsScreen(),
      ),
    ),
  ],
);

List<GoRoute> recipeRoutes = [
  GoRoute(
    path: AppRoutes.categorySeeAll,
    name: AppRouteNames.categorySeeAll,
    builder: (_, state) {
      final category = state.extra! as String;
      return AllRecipesScreen(category: category);
    },
  ),
];
