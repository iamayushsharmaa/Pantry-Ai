part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailEvent {}

class LoadRecipeById extends RecipeDetailEvent {
  final String recipeId;

  LoadRecipeById(this.recipeId);
}

class LoadRecipeFromMemory extends RecipeDetailEvent {
  final Recipe recipe;
  LoadRecipeFromMemory(this.recipe);
}

