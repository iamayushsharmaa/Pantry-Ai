import 'package:pantry_ai/features/recipes/data/models/recipe_model.dart';

class AiRecipeResponse {
  final List<String> detectedIngredients;
  final List<Recipe> recipes;

  AiRecipeResponse({
    required this.detectedIngredients,
    required this.recipes,
  });

  factory AiRecipeResponse.fromJson(Map<String, dynamic> json) {
    return AiRecipeResponse(
      detectedIngredients: List<String>.from(json['detectedIngredients']),
      recipes: (json['recipes'] as List)
          .map((e) => Recipe.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'detectedIngredients': detectedIngredients,
    'recipes': recipes.map((e) => e.toJson()).toList(),
  };
}
