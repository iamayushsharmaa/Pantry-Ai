import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/recipe_model.dart';
import '../../domain/entities/favorite_recipe_entity.dart';

class FavoriteRecipeModel {
  final String userId;
  final String recipeId;
  final DateTime favoritedAt;
  final Map<String, dynamic> recipeJson;

  FavoriteRecipeModel({
    required this.userId,
    required this.recipeId,
    required this.favoritedAt,
    required this.recipeJson,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'recipeId': recipeId,
      'favoritedAt': Timestamp.fromDate(favoritedAt),
      'recipe': recipeJson,
    };
  }

  factory FavoriteRecipeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteRecipeModel(
      userId: data['userId'] as String,
      recipeId: data['recipeId'] as String,
      favoritedAt: (data['favoritedAt'] as Timestamp).toDate(),
      recipeJson: Map<String, dynamic>.from(data['recipe']),
    );
  }

  FavoriteRecipe toEntity() {
    return FavoriteRecipe(
      userId: userId,
      recipeId: recipeId,
      favoritedAt: favoritedAt,
      recipe: RecipeModel.fromJson(recipeJson),
    );
  }

  factory FavoriteRecipeModel.fromRecipe({
    required String userId,
    required Recipe recipe,
  }) {
    return FavoriteRecipeModel(
      userId: userId,
      recipeId: recipe.id,
      favoritedAt: DateTime.now(),
      recipeJson: RecipeModel.fromEntity(recipe).toJson(),
    );
  }
}
