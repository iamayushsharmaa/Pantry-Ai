import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/favorites/data/models/favorite_model.dart';
import '../recipe/recipe_model.dart';
import '../recipe/recipe_snapshot_model.dart';

extension RecipeModelX on RecipeModel {
  FavoriteRecipeModel toFavoriteModel(String userId) => FavoriteRecipeModel(
    userId: userId,
    recipeId: id,
    favoritedAt: DateTime.now(),
    recipeSnapshot: RecipeSnapshot.fromRecipe(this),
  );
}

extension DocumentSnapshotX on DocumentSnapshot {
  FavoriteRecipeModel toFavoriteRecipeModel() {
    final data = this.data() as Map<String, dynamic>;
    return FavoriteRecipeModel(
      userId: data['userId'] as String,
      recipeId: data['recipeId'] as String,
      favoritedAt: (data['favoritedAt'] as Timestamp).toDate(),
      recipeSnapshot: RecipeSnapshot.fromJson(
        data['recipeSnapshot'] as Map<String, dynamic>,
      ),
    );
  }
}