import '../../domain/enities/recipe_entity.dart';
import 'ingredients_model.dart';

class RecipeModel extends Recipe {
  @override
  final List<IngredientModel> ingredients;

  RecipeModel({
    required super.title,
    required super.imageUrl,
    required super.cookingTime,
    required super.difficulty,
    required this.ingredients,
    required super.missingIngredients,
    required super.instructions,
  }) : super(ingredients: ingredients);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'],
      imageUrl: json['imageUrl'],
      cookingTime: json['cookingTime'],
      difficulty: json['difficulty'],
      ingredients: (json['ingredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
      missingIngredients: List<String>.from(json['missingIngredients']),
      instructions: List<String>.from(json['instructions']),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'imageUrl': imageUrl,
    'cookingTime': cookingTime,
    'difficulty': difficulty,
    'ingredients': ingredients
        .map((e) => IngredientModel.fromEntity(e))
        .toList(),
    'missingIngredients': missingIngredients,
    'instructions': instructions,
  };

  factory RecipeModel.fromEntity(Recipe entity) {
    return RecipeModel(
      title: entity.title,
      imageUrl: entity.imageUrl,
      cookingTime: entity.cookingTime,
      difficulty: entity.difficulty,
      ingredients: entity.ingredients
          .map((e) => IngredientModel.fromEntity(e))
          .toList(),
      missingIngredients: entity.missingIngredients,
      instructions: entity.instructions,
    );
  }

  Recipe toEntity() {
    return Recipe(
      title: title,
      imageUrl: imageUrl,
      cookingTime: cookingTime,
      difficulty: difficulty,
      ingredients: ingredients.map((e) => e.toEntity()).toList(),
      missingIngredients: missingIngredients,
      instructions: instructions,
    );
  }
}
