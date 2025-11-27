import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

class CookingSession {
  final String id;
  final String userId;
  final String recipeId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final RecipeSnapshot recipeSnapshot;
  final int currentStep; // Track which instruction step user is on
  final bool isActive;

  CookingSession({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.startedAt,
    this.completedAt,
    required this.recipeSnapshot,
    required this.currentStep,
    required this.isActive,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'recipeId': recipeId,
      'startedAt': Timestamp.fromDate(startedAt),
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'recipeSnapshot': recipeSnapshot.toMap(),
      'currentStep': currentStep,
      'isActive': isActive,
    };
  }

  factory CookingSession.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CookingSession(
      id: doc.id,
      userId: data['userId'],
      recipeId: data['recipeId'],
      startedAt: (data['startedAt'] as Timestamp).toDate(),
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      recipeSnapshot: RecipeSnapshot.fromJson(data['recipeSnapshot']),
      currentStep: data['currentStep'],
      isActive: data['isActive'],
    );
  }
}