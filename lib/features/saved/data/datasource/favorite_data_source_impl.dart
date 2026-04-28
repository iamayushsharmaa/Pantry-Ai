import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../model/favorite_model.dart';
import 'favorite_data_source.dart';

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FavoriteRemoteDataSourceImpl({required this.firestore, required this.auth});

  String get _uid => auth.currentUser?.uid ?? '';

  CollectionReference get _favCol =>
      firestore.collection('users').doc(_uid).collection('favorites');

  @override
  Future<void> addToFavorites(Recipe recipe) async {
    final model = FavoriteRecipeModel.fromRecipe(userId: _uid, recipe: recipe);
    await _favCol.doc(recipe.id).set(model.toFirestore());
  }

  @override
  Future<void> removeFromFavorites(String recipeId) async {
    await _favCol.doc(recipeId).delete();
  }

  @override
  Future<bool> isFavorite(String recipeId) async {
    final doc = await _favCol.doc(recipeId).get();
    return doc.exists;
  }

  @override
  Stream<List<FavoriteRecipeModel>> getFavoritesStream() {
    return firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .orderBy('favoritedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => FavoriteRecipeModel.fromFirestore(doc))
              .toList(),
        );
  }

  @override
  Future<List<FavoriteRecipeModel>> getFavoritesOnce() async {
    final snapshot = await _favCol
        .orderBy('favoritedAt', descending: true)
        .get();

    return snapshot.docs.map(FavoriteRecipeModel.fromFirestore).toList();
  }
}
