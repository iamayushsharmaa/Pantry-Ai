import '../../../../shared/models/recipe/recipe_snapshot_model.dart';

class FavoriteRecipe {
  final String userId;
  final String recipeId;
  final DateTime favoritedAt;
  final RecipeSnapshot recipeSnapshot;

  FavoriteRecipe({
    required this.userId,
    required this.recipeId,
    required this.favoritedAt,
    required this.recipeSnapshot,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteRecipe &&
          runtimeType == other.runtimeType &&
          recipeId == other.recipeId;

  @override
  int get hashCode => recipeId.hashCode;
}
