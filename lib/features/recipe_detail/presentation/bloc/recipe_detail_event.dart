part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailEvent {}

class LoadRecipeDetail extends RecipeDetailEvent {
  final String recipeId;

  LoadRecipeDetail(this.recipeId);
}
