import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/features/save_recipe/data/datasource/saved_datasource.dart';

import '../../../../shared/models/recipe/recipe_model.dart';
import '../../../../shared/models/recipe/recipe_snapshot_model.dart';
import '../../../../shared/models/recipe/saved_recipe_model.dart';

class SavedRemoteDataSourceImpl implements SavedRemoteDataSource {
  final FirebaseFirestore firestore;
  final String uid;

  SavedRemoteDataSourceImpl(this.firestore, this.uid);

  CollectionReference get _col =>
      firestore.collection('users').doc(uid).collection('saved_recipes');

  @override
  Future<void> saveRecipe(RecipeModel recipe, {String? notes}) async {
    final saved = SavedRecipe(
      userId: uid,
      recipeId: recipe.id,
      savedAt: DateTime.now(),
      recipeSnapshot: RecipeSnapshot.fromRecipe(recipe),
      notes: notes,
    );
    await _col.doc(recipe.id).set(saved.toFirestore());
  }

  @override
  Future<void> unsaveRecipe(String recipeId) async =>
      await _col.doc(recipeId).delete();

  @override
  Future<bool> isSaved(String recipeId) async =>
      (await _col.doc(recipeId).get()).exists;

  @override
  Stream<List<SavedRecipe>> getSavedStream() => _col
      .orderBy('savedAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map(SavedRecipe.fromFirestore).toList());
}
