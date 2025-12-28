import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../shared/models/recipe/recipe_model.dart';
import 'user_remote_datasource.dart';

class UserRecipesRemoteDataSourceImpl implements UserRecipesRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRecipesRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<RecipeModel>> getQuickRecipes({
    required String userId,
    required int maxCookingTime,
  }) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('recipes')
        .where('cookingTime', isLessThanOrEqualTo: maxCookingTime)
        .orderBy('cookingTime')
        .limit(10)
        .get();

    return snapshot.docs.map((doc) => RecipeModel.fromFirestore(doc)).toList();
  }
}
