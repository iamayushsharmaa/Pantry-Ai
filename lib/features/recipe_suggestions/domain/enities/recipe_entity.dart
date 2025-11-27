import 'ingredient_entity.dart';
import 'nutrition_info.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int cookingTime;
  final int prepTime;
  final int difficulty;
  final int servings;
  final String cuisine;
  final List<String> dietaryInfo;
  final double rating;
  final int calories;
  final NutritionInfo nutrition;
  final List<Ingredient> ingredients;
  final List<String> missingIngredients;
  final List<String> instructions;
  final List<String> tags;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.cookingTime,
    required this.prepTime,
    required this.difficulty,
    required this.servings,
    required this.cuisine,
    required this.dietaryInfo,
    required this.rating,
    required this.calories,
    required this.nutrition,
    required this.ingredients,
    required this.missingIngredients,
    required this.instructions,
    required this.tags,
  });
}
