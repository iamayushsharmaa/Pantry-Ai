import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/recipe_detail/presentation/screens/recipe_detail_screen.dart';

import '../../../core/di/injections.dart';
import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import '../../../shared/models/recipe/recipe.dart';
import 'bloc/recipe_detail_bloc.dart';

List<GoRoute> detailRecipeRoutes = [
  GoRoute(
    path: AppRoutes.recipeDetail,
    name: AppRouteNames.recipeDetail,
    builder: (_, state) {
      final extra = state.extra;

      return BlocProvider(
        create: (_) => sl<RecipeDetailBloc>()
          ..add(
            extra is Recipe
                ? LoadRecipeFromMemory(extra)
                : LoadRecipeById(extra as String),
          ),
        child: RecipeDetailScreen(
          recipe: extra is Recipe ? extra : null,
          recipeId: extra is String ? extra : null,
        ),
      );
    },
  ),
];
