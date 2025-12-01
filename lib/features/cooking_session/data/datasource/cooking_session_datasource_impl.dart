import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/cooking_session_entity.dart';
import '../models/cooking_session_model.dart';
import 'cooking_session_datasources.dart';

class CookingRemoteDataSourceImpl implements CookingRemoteDataSource {
  final FirebaseFirestore firestore;

  CookingRemoteDataSourceImpl({required this.firestore});

  @override
  Future<CookingSessionModel> startCookingSession({
    required String userId,
    required String recipeId,
    required String recipeName,
    required int totalSteps,
    required List<String> ingredientIds,
    required int servings,
  }) async {
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('cooking_sessions')
        .doc();

    final ingredientChecklist = {for (var id in ingredientIds) id: false};

    final session = CookingSessionModel(
      id: docRef.id,
      recipeId: recipeId,
      recipeName: recipeName,
      currentStep: 0,
      totalSteps: totalSteps,
      servings: servings,
      startedAt: DateTime.now(),
      completedSteps: [],
      ingredientChecklist: ingredientChecklist,
      status: CookingStatus.inProgress,
    );

    await docRef.set(session.toFirestore());
    return session;
  }

  @override
  Future<CookingSessionModel> updateCookingSession(
    String userId,
    CookingSessionModel session,
  ) async {
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('cooking_sessions')
        .doc(session.id);

    await docRef.update(session.toFirestore());
    return session;
  }

  @override
  Future<void> completeCookingSession(String userId, String sessionId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('cooking_sessions')
        .doc(sessionId)
        .update({
          'status': CookingStatus.completed.name,
          'completedAt': FieldValue.serverTimestamp(),
        });
  }

  @override
  Future<CookingSessionModel?> getActiveCookingSession(
    String userId,
    String recipeId,
  ) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('cooking_sessions')
        .where('recipeId', isEqualTo: recipeId)
        .where('status', isEqualTo: CookingStatus.inProgress.name)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return CookingSessionModel.fromFirestore(snapshot.docs.first);
  }

  @override
  Future<List<CookingSessionModel>> getCookingHistory(
    String userId, {
    int limit = 20,
  }) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('cooking_sessions')
        .where('status', isEqualTo: CookingStatus.completed.name)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => CookingSessionModel.fromFirestore(doc))
        .toList();
  }
}
