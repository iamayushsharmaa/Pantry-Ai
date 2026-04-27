import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/shared/models/recipe/recipe.dart';

class RecipeSnapshot {
  final String id;
  final String title;
  final String imageUrl;
  final int difficulty;
  final int cookingTime;
  final int calories;
  final int servings;
  final String cuisine;
  final List<String> tags;

  RecipeSnapshot({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.difficulty,
    required this.cookingTime,
    required this.calories,
    required this.servings,
    required this.cuisine,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'difficulty': difficulty,
      'cookingTime': cookingTime,
      'calories': calories,
      'servings': servings,
      'cuisine': cuisine,
      'tags': tags,
    };
  }

  factory RecipeSnapshot.fromJson(Map<String, dynamic> map) {
    return RecipeSnapshot(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      difficulty: (map['difficulty'] as num?)?.toInt() ?? 1,
      cookingTime: (map['cookingTime'] as num?)?.toInt() ?? 0,
      calories: (map['calories'] as num?)?.toInt() ?? 0,
      servings: (map['servings'] as num?)?.toInt() ?? 1,
      cuisine: map['cuisine']?.toString() ?? '',
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  factory RecipeSnapshot.fromRecipe(Recipe recipe) {
    return RecipeSnapshot(
      id: recipe.id,
      title: recipe.title,
      imageUrl: recipe.imageUrl ?? "",
      difficulty: recipe.difficulty,
      cookingTime: recipe.cookingTime,
      calories: recipe.calories,
      servings: recipe.servings,
      cuisine: recipe.cuisine,
      tags: recipe.tags,
    );
  }

  factory RecipeSnapshot.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RecipeSnapshot.fromJson(data);
  }

  Recipe toEntity() {
    return Recipe(
      id: id,
      title: title,
      description: '',
      imageUrl: imageUrl,
      cookingTime: cookingTime,
      prepTime: 0,
      difficulty: difficulty,
      servings: servings,
      cuisine: cuisine,
      dietaryInfo: const [],
      rating: 0,
      calories: calories,
      nutrition: NutritionInfo(protein: 0, carbs: 0, fat: 0, fiber: 0),
      ingredients: const [],
      missingIngredients: const [],
      instructions: const [],
      tags: tags,
    );
  }
}
