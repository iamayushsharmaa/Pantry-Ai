part of 'recipe_bloc.dart';

@immutable
class RecipeState {
  final List<Recipe> recipes;
  final String? imagePath;
  final TastePreferences? preferences;
  final bool isLoading;
  final String? error;

  RecipeState({
    this.recipes = const [],
    this.imagePath,
    this.preferences,
    this.isLoading = false,
    this.error,
  });

  RecipeState copyWith({
    List<Recipe>? recipes,
    String? imagePath,
    TastePreferences? preferences,
    bool? isLoading,
    String? error,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      imagePath: imagePath ?? this.imagePath,
      preferences: preferences ?? this.preferences,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
