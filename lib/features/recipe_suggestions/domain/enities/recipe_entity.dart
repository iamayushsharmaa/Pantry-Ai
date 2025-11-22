import 'ingredient_entity.dart';

class Recipe {
  final String title;
  final String imageUrl;
  final int cookingTime; // in minutes
  final int difficulty; // 1-5 scale
  final double rating; // 0-5 stars
  final int calories; // per serving
  final int servings; // number of servings
  final String? description;
  final String? cuisine; // e.g., "Italian", "Mexican"
  final List<String>? dietaryInfo; // e.g., ["Vegetarian", "Gluten-Free"]
  final List<Ingredient> ingredients;
  final List<String> missingIngredients;
  final List<String> instructions;

  const Recipe({
    required this.title,
    required this.imageUrl,
    required this.cookingTime,
    required this.difficulty,
    required this.rating,
    required this.calories,
    required this.servings,
    this.description,
    this.cuisine,
    this.dietaryInfo,
    required this.ingredients,
    required this.missingIngredients,
    required this.instructions,
  });
}