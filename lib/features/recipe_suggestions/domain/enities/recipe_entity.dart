import 'ingredient_entity.dart';

class Recipe {
  final String title;
  final String imageUrl;
  final int cookingTime;
  final int difficulty;
  final List<Ingredient> ingredients;
  final List<String> missingIngredients;
  final List<String> instructions;

  const Recipe({
    required this.title,
    required this.imageUrl,
    required this.cookingTime,
    required this.difficulty,
    required this.ingredients,
    required this.missingIngredients,
    required this.instructions,
  });
}
