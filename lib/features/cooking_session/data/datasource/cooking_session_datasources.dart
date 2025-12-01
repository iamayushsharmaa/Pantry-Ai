import '../models/cooking_session_model.dart';

abstract class CookingRemoteDataSource {
  Future<CookingSessionModel> startCookingSession({
    required String userId,
    required String recipeId,
    required String recipeName,
    required int totalSteps,
    required List<String> ingredientIds,
    required int servings,
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
}
