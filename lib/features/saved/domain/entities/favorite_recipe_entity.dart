import '../../../../shared/models/recipe/recipe.dart';

class FavoriteRecipe {
  final String userId;
  final String recipeId;
  final DateTime favoritedAt;
  final Recipe recipe;

  FavoriteRecipe({
    required this.userId,
    required this.recipeId,
    required this.favoritedAt,
    required this.recipe,
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
