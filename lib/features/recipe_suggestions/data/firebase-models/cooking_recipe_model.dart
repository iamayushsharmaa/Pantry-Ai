import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

class CookedRecipe {
  final String id; // Auto-generated
  final String userId;
  final String recipeId;
  final DateTime cookedAt;
  final RecipeSnapshot recipeSnapshot;
  final int actualCookingTime; // Optional: user can log actual time
  final double? userRating; // Optional: user rating after cooking
  final String? feedback; // Optional: user feedback

  CookedRecipe({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.cookedAt,
    required this.recipeSnapshot,
    required this.actualCookingTime,
    this.userRating,
    this.feedback,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'recipeId': recipeId,
      'cookedAt': Timestamp.fromDate(cookedAt),
      'recipeSnapshot': recipeSnapshot.toJson(),
      'actualCookingTime': actualCookingTime,
      'userRating': userRating,
      'feedback': feedback,
    };
  }

  factory CookedRecipe.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CookedRecipe(
      id: doc.id,
      userId: data['userId'],
      recipeId: data['recipeId'],
      cookedAt: (data['cookedAt'] as Timestamp).toDate(),
      recipeSnapshot: RecipeSnapshot.fromJson(data['recipeSnapshot']),
      actualCookingTime: data['actualCookingTime'],
      userRating: data['userRating']?.toDouble(),
      feedback: data['feedback'],
    );
  }
}