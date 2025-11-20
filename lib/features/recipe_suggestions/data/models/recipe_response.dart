import 'package:pantry_ai/features/recipe_suggestions/data/models/recipe_model.dart';

class AiRecipeResponse {
  final List<String> detectedIngredients;
  final List<RecipeModel> recipes;

  AiRecipeResponse({required this.detectedIngredients, required this.recipes});

  factory AiRecipeResponse.fromJson(Map<String, dynamic> json) {
    return AiRecipeResponse(
      detectedIngredients: List<String>.from(json['detectedIngredients']),
      recipes: (json['recipe_suggestions'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'detectedIngredients': detectedIngredients,
    'recipe_suggestions': recipes.map((e) => e.toJson()).toList(),
  };
}
