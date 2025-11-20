part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}


class GenerateRecipesRequested extends RecipeEvent {
  final String imagePath;
  final TastePreferences preferences;

  GenerateRecipesRequested(this.imagePath, this.preferences);
}

class FetchMoreRecipesRequested extends RecipeEvent {}

class LoadCachedRecipesRequested extends RecipeEvent {}