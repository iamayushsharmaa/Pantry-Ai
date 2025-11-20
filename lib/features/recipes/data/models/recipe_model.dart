import 'ingredients_model.dart';

class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final List<String> missingIngredients;
  final int cookingTime;
  final int difficulty;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.missingIngredients,
    required this.cookingTime,
    required this.difficulty,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      cookingTime: json['cookingTime'],
      difficulty: json['difficulty'],
      ingredients: (json['ingredients'] as List)
          .map((e) => Ingredient.fromJson(e))
          .toList(),
      instructions: List<String>.from(json['instructions']),
      missingIngredients: List<String>.from(json['missingIngredients']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'imageUrl': imageUrl,
    'ingredients': ingredients.map((e) => e.toJson()).toList(),
    'instructions': instructions,
    'missingIngredients': missingIngredients,
    'cookingTime': cookingTime,
    'difficulty': difficulty,
  };
}
