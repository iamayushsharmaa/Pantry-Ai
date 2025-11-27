part of 'saved_bloc.dart';

class SavedState {
  final List<SavedRecipe> savedRecipes;
  final Set<String> savedRecipeIds;
  final bool isLoading;

  const SavedState({
    required this.savedRecipes,
    required this.savedRecipeIds,
    this.isLoading = false,
  });

  factory SavedState.initial() =>
      const SavedState(savedRecipes: [], savedRecipeIds: {});

  SavedState copyWith({
    List<SavedRecipe>? savedRecipes,
    Set<String>? savedRecipeIds,
    bool? isLoading,
  }) {
    return SavedState(
      savedRecipes: savedRecipes ?? this.savedRecipes,
      savedRecipeIds: savedRecipeIds ?? this.savedRecipeIds,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
