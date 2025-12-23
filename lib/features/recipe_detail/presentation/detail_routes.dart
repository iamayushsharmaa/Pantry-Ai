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
        create: (_) {
          final bloc = sl<RecipeDetailBloc>();

          if (extra is Recipe) {
            bloc.add(LoadRecipeFromMemory(extra));
          } else if (extra is String) {
            bloc.add(LoadRecipeById(extra));
          } else {
            throw Exception('Invalid recipe detail route argument');
          }

          return bloc;
        },
        child: RecipeDetailScreen(), // ✅ no params
      );
    },
  ),
];
