import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/features/save_recipe/data/datasource/saved_datasource.dart';

import '../model/saved_recipe_model.dart';

class SavedRemoteDataSourceImpl implements SavedRemoteDataSource {
  final FirebaseFirestore firestore;

  SavedRemoteDataSourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> _col(String uid) {
    return firestore.collection('users').doc(uid).collection('saved_recipes');
  }

  @override
  Future<void> saveRecipe({
    required String uid,
    required SavedRecipeModel recipe,
  }) async {
    await _col(uid).doc(recipe.recipeId).set(recipe.toFirestore());
  }

  @override
  Future<void> unsaveRecipe({
    required String uid,
    required String recipeId,
  }) async {
    await _col(uid).doc(recipeId).delete();
  }

  @override
  Future<bool> isSaved({required String uid, required String recipeId}) async {
    return (await _col(uid).doc(recipeId).get()).exists;
  }

  @override
  Stream<List<SavedRecipeModel>> getSavedStream(String uid) {
    return _col(uid)
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map(SavedRecipeModel.fromFirestore).toList(),
        );
  }
}
