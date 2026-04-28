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
      imageUrl: json['imageUrl']?.toString() ?? '',
      cookingTime: json['cookingTime'] as int? ?? 0,
      prepTime: json['prepTime'] as int? ?? 0,
      difficulty: json['difficulty'] as int? ?? 1,
      servings: json['servings'] as int? ?? 1,
      cuisine: json['cuisine'] ?? '',
      dietaryInfo: List<String>.from(json['dietaryInfo'] ?? const []),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      calories: json['calories'] as int? ?? 0,
      nutrition: NutritionInfoModel.fromJson(
        Map<String, dynamic>.from(json['nutrition'] ?? {}),
      ),

      ingredients: (json['ingredients'] as List? ?? [])
          .asMap()
          .entries
          .map(
            (e) => IngredientModel.fromJson(
              Map<String, dynamic>.from(e.value),
              fallbackId: 'ing_${e.key}',
            ),
          )
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

  factory RecipeModel.fromEntity(Recipe recipe) {
    return RecipeModel(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      imageUrl: recipe.imageUrl,
      cookingTime: recipe.cookingTime,
      prepTime: recipe.prepTime,
      difficulty: recipe.difficulty,
      servings: recipe.servings,
      cuisine: recipe.cuisine,
      dietaryInfo: recipe.dietaryInfo,
      rating: recipe.rating,
      calories: recipe.calories,
      nutrition: NutritionInfoModel(
        protein: recipe.nutrition.protein,
        carbs: recipe.nutrition.carbs,
        fat: recipe.nutrition.fat,
        fiber: recipe.nutrition.fiber,
      ),
      ingredients: recipe.ingredients
          .map(
            (i) => IngredientModel(
              id: i.id,
              name: i.name,
              quantity: i.quantity,
              unit: i.unit,
              isAvailable: i.isAvailable,
            ),
          )
          .toList(),
      missingIngredients: recipe.missingIngredients,
      instructions: recipe.instructions,
      tags: recipe.tags,
    );
  }
}
