import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:pantry_ai/features/home/presentation/screens/widget_tree.dart';
import 'package:pantry_ai/features/preference/presentation/screens/taste_preference_screen.dart';
import 'package:pantry_ai/splash.dart';

import '../core/common/recipe_list_args.dart';
import '../core/di/injections.dart';
import '../features/analytics/presentation/screens/analytics_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/preference/presentation/bloc/taste_preference_bloc.dart';
import '../features/recipe_suggestions/domain/usecases/cache_reccipe_usecase.dart';
import '../features/recipe_suggestions/domain/usecases/generate_recipe_usecase.dart';
import '../features/recipe_suggestions/domain/usecases/get_cached_recipes_usecase.dart';
import '../features/recipe_suggestions/presentation/bloc/recipe_bloc.dart';
import '../features/recipe_suggestions/presentation/screens/recipe_detail_screen.dart';
import '../features/recipe_suggestions/presentation/screens/recipe_suggestion_screen.dart';
import '../features/scan/presentation/bloc/scan_bloc.dart';
import '../features/scan/presentation/screens/scan_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

GoRouter createRouter() {
  final initialLocation = '/splash';

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
        path: '/recipe-details',
        name: 'recipeDetails',
        builder: (context, state) => DishesDetailScreen(),
      ),
      GoRoute(
        path: '/recipes-list',
        name: 'recipesList',
        builder: (context, state) {
          final args = state.extra as RecipeListArgs;

          return BlocProvider(
            create: (_) => RecipeBloc(
              generateRecipes: sl<GenerateRecipesUseCase>(),
              getCachedRecipes: sl<GetCachedRecipesUseCase>(),
              cacheRecipes: sl<CacheRecipesUseCase>(),
            )..add(GenerateRecipesRequested(args.imagePath, args.preferences)),
            child: RecipeListScreen(),
          );
        },
      ),

      GoRoute(
        path: '/scan',
        name: 'scan',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => ScanBloc()..add(InitializeCamera()),
            child: const ScanScreen(),
          );
        },
      ),
      GoRoute(
        path: '/taste-preference',
        name: 'tastePreference',
        builder: (context, state) {
          final imagePath = state.extra as String;
          return BlocProvider(
            create: (_) => TastePreferenceBloc(),
            child: TastePreferenceScreen(imagePath: imagePath),
          );
        },
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
