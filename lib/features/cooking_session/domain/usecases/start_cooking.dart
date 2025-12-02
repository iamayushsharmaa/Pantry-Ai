import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pantry_ai/shared/models/recipe/recipe.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/cooking_session_entity.dart';
import '../repository/cooking_repository.dart';

class StartCooking implements UseCase<CookingSession, StartCookingParams> {
  final CookingRepository repository;

  StartCooking(this.repository);

  @override
  Future<Either<Failure, CookingSession>> call(
      StartCookingParams params,) async =>
      await repository.startCookingSession(
        recipeId: params.recipeId,
        recipeName: params.recipeName,
        totalSteps: params.totalSteps,
        ingredientIds: params.ingredientIds,
        servings: params.servings,
        instructions: params.instructions,
      );
}

class StartCookingParams extends Equatable {
  final String recipeId;
  final String recipeName;
  final int totalSteps;
  final List<String> ingredientIds;
  final int servings;
  final List<String> instructions;


  const StartCookingParams({

    required this.recipeId,
    required this.recipeName,
    required this.instructions,
    required this.totalSteps,
    required this.ingredientIds,
    required this.servings,
  });

  @override
  List<Object?> get props =>
      [
        recipeId,
        recipeName,
        totalSteps,
        ingredientIds,
        instructions,
        servings,
      ];
}
