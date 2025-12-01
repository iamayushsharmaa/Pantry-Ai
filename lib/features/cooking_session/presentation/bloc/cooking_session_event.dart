part of 'cooking_session_bloc.dart';

abstract class CookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartCookingEvent extends CookingEvent {
  final String recipeId;
  final String recipeName;
  final int totalSteps;
  final List<String> ingredientIds;
  final int servings;

  StartCookingEvent({
    required this.recipeId,
    required this.recipeName,
    required this.totalSteps,
    required this.ingredientIds,
    required this.servings,
  });

  @override
  List<Object?> get props => [
    recipeId,
    recipeName,
    totalSteps,
    ingredientIds,
    servings,
  ];
}

class LoadActiveSessionEvent extends CookingEvent {
  final String recipeId;

  LoadActiveSessionEvent(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}

class NextStepEvent extends CookingEvent {}

class PreviousStepEvent extends CookingEvent {}

class JumpToStepEvent extends CookingEvent {
  final int stepIndex;

  JumpToStepEvent(this.stepIndex);

  @override
  List<Object?> get props => [stepIndex];
}

class ToggleIngredientEvent extends CookingEvent {
  final String ingredientId;
  final bool isChecked;

  ToggleIngredientEvent({required this.ingredientId, required this.isChecked});

  @override
  List<Object?> get props => [ingredientId, isChecked];
}

class CompleteCookingEvent extends CookingEvent {}

class AbandonCookingEvent extends CookingEvent {}
