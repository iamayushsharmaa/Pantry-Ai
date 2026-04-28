import 'package:cloud_firestore/cloud_firestore.dart';

import '../recipe/recipe.dart';
import '../recipe/recipe_model.dart';
import 'save_recipe.dart';

class SavedRecipeModel {
  final String recipeId;
  final DateTime savedAt;
  final Map<String, dynamic> recipeJson;
  final String? notes;

  SavedRecipeModel({
    required this.recipeId,
    required this.savedAt,
    required this.recipeJson,
    this.notes,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'recipeId': recipeId,
      'savedAt': Timestamp.fromDate(savedAt),
      'recipe': recipeJson,
      'notes': notes,
    };
  }

  factory SavedRecipeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SavedRecipeModel(
      recipeId: data['recipeId'] as String,
      savedAt: (data['savedAt'] as Timestamp).toDate(),
      recipeJson: Map<String, dynamic>.from(data['recipe']),
      notes: data['notes'] as String?,
    );
  }

  SavedRecipe toEntity() {
    return SavedRecipe(
      recipeId: recipeId,
      savedAt: savedAt,
      recipe: RecipeModel.fromJson(recipeJson),
      notes: notes,
    );
  }

  factory SavedRecipeModel.fromRecipe({required Recipe recipe, String? notes}) {
    return SavedRecipeModel(
      recipeId: recipe.id,
      savedAt: DateTime.now(),
      recipeJson: RecipeModel.fromEntity(recipe).toJson(),
      notes: notes,
    );
  }
}
