import '../../../../shared/models/recipe/recipe.dart';

class SavedRecipe {
  final String recipeId;
  final DateTime savedAt;
  final Recipe recipe;
  final String? notes;

  const SavedRecipe({
    required this.recipeId,
    required this.savedAt,
    required this.recipe,
    this.notes,
  });
}
