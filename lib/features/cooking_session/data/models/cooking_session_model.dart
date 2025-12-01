import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/cooking_session_entity.dart';

class CookingSessionModel extends CookingSession {
  const CookingSessionModel({
    required super.id,
    required super.recipeId,
    required super.recipeName,
    required super.currentStep,
    required super.totalSteps,
    required super.servings,
    required super.startedAt,
    super.completedAt,
    required super.completedSteps,
    required super.ingredientChecklist,
    required super.status,
  });

  factory CookingSessionModel.fromEntity(CookingSession session) {
    return CookingSessionModel(
      id: session.id,
      recipeId: session.recipeId,
      recipeName: session.recipeName,
      currentStep: session.currentStep,
      totalSteps: session.totalSteps,
      servings: session.servings,
      startedAt: session.startedAt,
      completedAt: session.completedAt,
      completedSteps: session.completedSteps,
      ingredientChecklist: session.ingredientChecklist,
      status: session.status,
    );
  }

  factory CookingSessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CookingSessionModel(
      id: doc.id,
      recipeId: data['recipeId'] as String,
      recipeName: data['recipeName'] as String,
      currentStep: data['currentStep'] as int,
      totalSteps: data['totalSteps'] as int,
      servings: data['servings'] as int,
      startedAt: (data['startedAt'] as Timestamp).toDate(),
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      completedSteps: List<int>.from(data['completedSteps'] ?? []),
      ingredientChecklist: Map<String, bool>.from(
        data['ingredientChecklist'] ?? {},
      ),
      status: CookingStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => CookingStatus.inProgress,
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'recipeId': recipeId,
      'recipeName': recipeName,
      'currentStep': currentStep,
      'totalSteps': totalSteps,
      'servings': servings,
      'startedAt': Timestamp.fromDate(startedAt),
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
      'completedSteps': completedSteps,
      'ingredientChecklist': ingredientChecklist,
      'status': status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
