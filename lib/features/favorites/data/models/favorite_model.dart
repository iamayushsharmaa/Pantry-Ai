import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/features/favorites/domain/entities/favorite_recipe_entity.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

class FavoriteRecipeModel extends FavoriteRecipe {
  FavoriteRecipeModel({
    required super.userId,
    required super.recipeId,
    required super.favoritedAt,
    required super.recipeSnapshot,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'recipeId': recipeId,
      'favoritedAt': Timestamp.fromDate(favoritedAt),
      'recipeSnapshot': recipeSnapshot.toJson(),
    };
  }

  factory FavoriteRecipeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteRecipeModel(
      userId: data['userId'],
      recipeId: data['recipeId'],
      favoritedAt: (data['favoritedAt'] as Timestamp).toDate(),
      recipeSnapshot: RecipeSnapshot.fromJson(data['recipeSnapshot']),
    );
  }
}
