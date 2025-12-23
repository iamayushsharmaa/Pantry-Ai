import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
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

  const Recipe({
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

  @override
  List<Object?> get props => [id];

}

class Ingredient extends Equatable {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final bool isAvailable;

  const Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [id];
}

class NutritionInfo extends Equatable {
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;

  const NutritionInfo({
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });

  @override
  List<Object?> get props => [protein, carbs, fat, fiber];
}
