import '../recipe/recipe.dart';
import '../recipe/recipe_model.dart';

class RecipeMapper {
  static RecipeModel toModel(Recipe recipe) {
    return RecipeModel(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      imageUrl: recipe.imageUrl,
      cookingTime: recipe.cookingTime,
      prepTime: recipe.prepTime,
      difficulty: recipe.difficulty,
      servings: recipe.servings,
      cuisine: recipe.cuisine,
      dietaryInfo: recipe.dietaryInfo,
      rating: recipe.rating,
      calories: recipe.calories,
      nutrition: recipe.nutrition,
      ingredients: recipe.ingredients,
      missingIngredients: recipe.missingIngredients,
      instructions: recipe.instructions,
      tags: recipe.tags,
    );
  }
}
