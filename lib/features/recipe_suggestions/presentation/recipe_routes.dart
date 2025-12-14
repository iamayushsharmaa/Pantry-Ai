import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/screens/recipe_suggestion_screen.dart';

import '../../../core/common/recipe_list_args.dart';
import '../../../core/di/injections.dart';
import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import 'bloc/recipe_bloc.dart';

List<GoRoute> recipeRoutes = [
  GoRoute(
    path: AppRoutes.recipesList,
    name: AppRouteNames.recipesList,
    builder: (_, state) {
      final args = state.extra! as RecipeListArgs;
      return BlocProvider(
        create: (_) => RecipeBloc(
          generateRecipes: sl(),
          getCachedRecipes: sl(),
          cacheRecipes: sl(),
        )..add(GenerateRecipesRequested(args.imagePath, args.preferences)),
        child: const RecipeListScreen(),
      );
    },
  ),
];
