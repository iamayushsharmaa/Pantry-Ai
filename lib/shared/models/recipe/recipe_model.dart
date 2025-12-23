import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/shared/models/recipe/recipe.dart';

import 'ingredients_model.dart';
import 'nutrition_info_model.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
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
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      cookingTime: json['cookingTime'] as int? ?? 0,
      prepTime: json['prepTime'] as int? ?? 0,
      difficulty: json['difficulty'] as int? ?? 1,
      servings: json['servings'] as int? ?? 1,
      cuisine: json['cuisine'] ?? '',
      dietaryInfo: List<String>.from(json['dietaryInfo'] ?? const []),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      calories: json['calories'] as int? ?? 0,
      nutrition: NutritionInfoModel.fromJson(json['nutrition'] ?? const {}),
      ingredients: (json['ingredients'] as List? ?? const [])
          .map((i) => IngredientModel.fromJson(i))
          .toList(),
      missingIngredients: List<String>.from(
        json['missingIngredients'] ?? const [],
      ),
      instructions: List<String>.from(json['instructions'] ?? const []),
      tags: List<String>.from(json['tags'] ?? const []),
    );
  }

  Map<String, dynamic> toJson() => {
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
  };

  Map<String, dynamic> toFirestore({bool includeTimestamp = true}) {
    return {
      ...toJson(),
      if (includeTimestamp) 'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory RecipeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return RecipeModel.fromJson({'id': doc.id, ...data});
  }

  factory RecipeModel.fromSnapshot(
    Map<String, dynamic> snapshot,
    String recipeId,
  ) {
    return RecipeModel(
      id: recipeId,
      title: snapshot['title'] ?? '',
      description: '',
      imageUrl: snapshot['imageUrl'] ?? '',
      cookingTime: snapshot['cookingTime'] as int? ?? 0,
      prepTime: 0,
      difficulty: snapshot['difficulty'] as int? ?? 1,
      servings: 1,
      cuisine: snapshot['cuisine'] ?? '',
      dietaryInfo: const [],
      rating: 0.0,
      calories: snapshot['calories'] as int? ?? 0,
      nutrition: const NutritionInfo(protein: 0, carbs: 0, fat: 0, fiber: 0),
      ingredients: const [],
      missingIngredients: const [],
      instructions: const [],
      tags: List<String>.from(snapshot['tags'] ?? const []),
    );
  }
}
