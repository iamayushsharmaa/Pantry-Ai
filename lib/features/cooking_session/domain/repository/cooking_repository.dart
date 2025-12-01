import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/cooking_session_entity.dart';

abstract class CookingRepository {
  Future<Either<Failure, CookingSession>> startCookingSession({
    required String recipeId,
    required String recipeName,
    required int totalSteps,
    required List<String> ingredientIds,
    required int servings,
  });

  Future<Either<Failure, CookingSession>> updateCookingSession(
    CookingSession session,
  );

  Future<Either<Failure, void>> completeCookingSession(String sessionId);

  Future<Either<Failure, CookingSession?>> getActiveCookingSession(
    String recipeId,
  );

  Future<Either<Failure, List<CookingSession>>> getCookingHistory({
    int limit = 20,
  });
}
