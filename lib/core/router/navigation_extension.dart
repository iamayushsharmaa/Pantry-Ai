import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/models/recipe/recipe.dart';
import '../common/recipe_list_args.dart';
import 'app_route_names.dart';

extension AppNavigation on BuildContext {
  void goToRecipeDetail(Recipe recipe) {
    goNamed(AppRouteNames.recipeDetail, extra: recipe);
  }

  void goToRecipesList(RecipeListArgs args) {
    goNamed(AppRouteNames.recipesList, extra: args);
  }

  void goToAnalytics() {
    goNamed(AppRouteNames.analytics);
  }
}
