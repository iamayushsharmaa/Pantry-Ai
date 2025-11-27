import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/features/recipe_detail/data/remote/recipe_detail_datasource.dart';

import '../../../../shared/models/recipe/recipe_model.dart';

class RecipeDetailRemoteDataSourceImpl implements RecipeDetailRemoteDataSource {
  final FirebaseFirestore firestore;

  RecipeDetailRemoteDataSourceImpl(this.firestore);

  @override
  Future<RecipeModel> getRecipeById(String recipeId) async {
    final doc = await firestore.collection('recipes').doc(recipeId).get();
    if (!doc.exists) throw Exception('Recipe not found');
    return RecipeModel.fromFirestore(doc);
  }
}
