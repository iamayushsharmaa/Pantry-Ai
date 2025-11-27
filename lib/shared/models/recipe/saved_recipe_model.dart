import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

class SavedRecipe {
  final String userId;
  final String recipeId;
  final DateTime savedAt;
  final RecipeSnapshot recipeSnapshot;
  final String? notes;

  SavedRecipe({
    required this.userId,
    required this.recipeId,
    required this.savedAt,
    required this.recipeSnapshot,
    this.notes,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'recipeId': recipeId,
      'savedAt': Timestamp.fromDate(savedAt),
      'recipeSnapshot': recipeSnapshot.toJson(),
      'notes': notes,
    };
  }

  factory SavedRecipe.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SavedRecipe(
      userId: data['userId'],
      recipeId: data['recipeId'],
      savedAt: (data['savedAt'] as Timestamp).toDate(),
      recipeSnapshot: RecipeSnapshot.fromJson(data['recipeSnapshot']),
      notes: data['notes'],
    );
  }
}
