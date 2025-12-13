import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/entities/save_recipe_entity.dart';

class SavedRecipeModel {
  final String recipeId;
  final DateTime savedAt;
  final RecipeSnapshot recipeSnapshot;
  final String? notes;

  SavedRecipeModel({
    required this.recipeId,
    required this.savedAt,
    required this.recipeSnapshot,
    this.notes,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'recipeId': recipeId,
      'savedAt': Timestamp.fromDate(savedAt),
      'recipeSnapshot': recipeSnapshot.toJson(),
      'notes': notes,
    };
  }

  factory SavedRecipeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SavedRecipeModel(
      recipeId: data['recipeId'],
      savedAt: (data['savedAt'] as Timestamp).toDate(),
      recipeSnapshot: RecipeSnapshot.fromJson(data['recipeSnapshot']),
      notes: data['notes'],
    );
  }

  SavedRecipe toEntity() {
    return SavedRecipe(
      recipeId: recipeId,
      savedAt: savedAt,
      recipe: recipeSnapshot.toEntity(),
      notes: notes,
    );
  }

  factory SavedRecipeModel.fromRecipe({required Recipe recipe, String? notes}) {
    return SavedRecipeModel(
      recipeId: recipe.id,
      savedAt: DateTime.now(),
      recipeSnapshot: RecipeSnapshot.fromRecipe(recipe),
      notes: notes,
    );
  }
}
