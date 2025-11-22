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
    required super.rating,
    required super.calories,
    required super.servings,
    super.description,
    super.cuisine,
    super.dietaryInfo,
    required this.ingredients,
    required super.missingIngredients,
    required super.instructions,
  }) : super(ingredients: ingredients);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      cookingTime: json['cookingTime'] as int,
      difficulty: json['difficulty'] as int,
      rating: (json['rating'] as num).toDouble(),
      calories: json['calories'] as int,
      servings: json['servings'] as int,
      description: json['description'] as String?,
      cuisine: json['cuisine'] as String?,
      dietaryInfo: json['dietaryInfo'] != null
          ? List<String>.from(json['dietaryInfo'])
          : null,
      ingredients: (json['ingredients'] as List)
          .map((i) => IngredientModel.fromJson(i))
          .toList(),
      missingIngredients: json['missingIngredients'] != null
          ? List<String>.from(json['missingIngredients'])
          : [],
      instructions: List<String>.from(json['instructions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'cookingTime': cookingTime,
      'difficulty': difficulty,
      'rating': rating,
      'calories': calories,
      'servings': servings,
      'description': description,
      'cuisine': cuisine,
      'dietaryInfo': dietaryInfo,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'missingIngredients': missingIngredients,
      'instructions': instructions,
    };
  }

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
      rating: entity.rating,
      calories: entity.calories,
      servings: entity.servings,
      description: entity.description,
      cuisine: entity.cuisine,
      dietaryInfo: entity.dietaryInfo,
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
      rating: rating,
      calories: calories,
      servings: servings,
      description: description,
      cuisine: cuisine,
      dietaryInfo: dietaryInfo,
    );
  }
}
