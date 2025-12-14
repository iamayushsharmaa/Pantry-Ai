import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/recipe_detail/presentation/screens/recipe_detail_screen.dart';

import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import '../../../shared/models/recipe/recipe.dart';

List<GoRoute> detailRecipeRoutes = [
  GoRoute(
    path: AppRoutes.recipeDetail,
    name: AppRouteNames.recipeDetail,
    builder: (_, state) {
      final recipe = state.extra! as Recipe;
      return RecipeDetailScreen(recipe: recipe);
    },
  ),
];
