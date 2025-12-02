import 'package:pantry_ai/features/cooking_session/data/models/cooking_step_model.dart';

import '../models/cooking_session_model.dart';

abstract class CookingRemoteDataSource {
  Future<CookingSessionModel> startCookingSession({
    required String userId,
    required String recipeId,
    required String recipeName,
    required int totalSteps,
    required List<String> ingredientIds,
    required int servings,
    required List<CookingStepModel> steps,
  });

  Future<CookingSessionModel> updateCookingSession(
    String userId,
    CookingSessionModel session,
  );

  Future<void> completeCookingSession(String userId, String sessionId);

  Future<CookingSessionModel?> getActiveCookingSession(
    String userId,
    String recipeId,
  );

  Future<List<CookingSessionModel>> getCookingHistory(
    String userId, {
    int limit = 20,
  });

  Stream<List<CookingSessionModel>> getCookingHistoryStream(String userId);
}
