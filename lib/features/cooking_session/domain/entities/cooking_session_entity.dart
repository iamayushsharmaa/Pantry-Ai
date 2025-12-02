import 'package:equatable/equatable.dart';
import 'package:pantry_ai/features/cooking_session/domain/entities/cooking_step.dart';

class CookingSession extends Equatable {
  final String id;
  final String recipeId;
  final String recipeName;
  final int currentStep;
  final int totalSteps;
  final int servings;
  final DateTime startedAt;
  final DateTime? completedAt;
  final List<int> completedSteps;
  final List<CookingStep> cookingSteps;
  final Map<String, bool> ingredientChecklist;
  final CookingStatus status;

  const CookingSession({
    required this.id,
    required this.recipeId,
    required this.recipeName,
    required this.currentStep,
    required this.totalSteps,
    required this.servings,
    required this.startedAt,
    this.completedAt,
    required this.cookingSteps,
    required this.completedSteps,
    required this.ingredientChecklist,
    required this.status,
  });

  CookingSession copyWith({
    String? id,
    String? recipeId,
    String? recipeName,
    int? currentStep,
    int? totalSteps,
    int? servings,
    DateTime? startedAt,
    DateTime? completedAt,
    List<int>? completedSteps,
    Map<String, bool>? ingredientChecklist,
    CookingStatus? status,
  }) {
    return CookingSession(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      recipeName: recipeName ?? this.recipeName,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      servings: servings ?? this.servings,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      cookingSteps: cookingSteps ?? this.cookingSteps,
      completedSteps: completedSteps ?? this.completedSteps,
      ingredientChecklist: ingredientChecklist ?? this.ingredientChecklist,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    recipeId,
    currentStep,
    completedSteps,
    ingredientChecklist,
    status,
  ];
}

enum CookingStatus { inProgress, completed, abandoned }
