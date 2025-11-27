import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/shared/models/recipe/recipe.dart';

import 'ingredients_model.dart';
import 'nutrition_info_model.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.cookingTime,
    required super.prepTime,
    required super.difficulty,
    required super.servings,
    required super.cuisine,
    required super.dietaryInfo,
    required super.rating,
    required super.calories,
    required super.nutrition,
    required super.ingredients,
    required super.missingIngredients,
    required super.instructions,
    required super.tags,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      cookingTime: json['cookingTime'] as int,
      prepTime: json['prepTime'] as int,
      difficulty: json['difficulty'] as int,
      servings: json['servings'] as int,
      cuisine: json['cuisine'] as String,
      dietaryInfo: List<String>.from(json['dietaryInfo'] ?? []),
      rating: (json['rating'] as num).toDouble(),
      calories: json['calories'] as int,
      nutrition: NutritionInfoModel.fromJson(json['nutrition']),
      ingredients: (json['ingredients'] as List)
          .map((i) => IngredientModel.fromJson(i))
          .toList(),
      missingIngredients: List<String>.from(json['missingIngredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'cookingTime': cookingTime,
      'prepTime': prepTime,
      'difficulty': difficulty,
      'servings': servings,
      'cuisine': cuisine,
      'dietaryInfo': dietaryInfo,
      'rating': rating,
      'calories': calories,
      'nutrition': {
        'protein': nutrition.protein,
        'carbs': nutrition.carbs,
        'fat': nutrition.fat,
        'fiber': nutrition.fiber,
      },
      'ingredients': ingredients
          .map(
            (i) => {
              'name': i.name,
              'quantity': i.quantity,
              'unit': i.unit,
              'isAvailable': i.isAvailable,
            },
          )
          .toList(),
      'missingIngredients': missingIngredients,
      'instructions': instructions,
      'tags': tags,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory RecipeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RecipeModel.fromJson(data);
  }

  factory RecipeModel.fromSnapshot(
    Map<String, dynamic> snapshot,
    String recipeId,
  ) => RecipeModel(
    id: recipeId,
    title: snapshot['title'] ?? '',
    imageUrl: snapshot['imageUrl'] ?? '',
    cookingTime: snapshot['cookingTime'] ?? 0,
    difficulty: snapshot['difficulty'] ?? 1,
    calories: snapshot['calories'] ?? 0,
    cuisine: snapshot['cuisine'] ?? '',
    tags: List<String>.from(snapshot['tags'] ?? []),
    // all other fields can stay empty or default
    description: '',
    prepTime: 0,
    servings: 1,
    dietaryInfo: const [],
    rating: 0.0,
    nutrition: NutritionInfo(protein: 0, carbs: 0, fat: 0, fiber: 0),
    ingredients: const [],
    missingIngredients: const [],
    instructions: const [],
  );
}
