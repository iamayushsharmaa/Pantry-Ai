import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../shared/models/recipe/recipe_snapshot_model.dart';
import '../models/favorite_model.dart';
import 'favorite_data_source.dart';

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FavoriteRemoteDataSourceImpl({required this.firestore, required this.auth});

  String get _uid => auth.currentUser?.uid ?? '';

  CollectionReference get _favCol =>
      firestore.collection('users').doc(_uid).collection('favorites');

  @override
  Future<void> addToFavorites(RecipeSnapshot snapshot) async {
    await _favCol.doc(snapshot.id).set({
      'recipeId': snapshot.id,
      'favoritedAt': FieldValue.serverTimestamp(),
      'recipeSnapshot': snapshot.toJson(),
    });
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
    final uid = auth.currentUser!.uid;
    return firestore
        .collection('users')
        .doc(uid)
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
