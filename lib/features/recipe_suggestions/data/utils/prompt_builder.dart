import 'package:pantry_ai/core/constant/ai_prompt.dart';

import '../../domain/enities/recipe_entity.dart';
import '../../domain/enities/taste_preference_entity.dart';

String buildPrompt(TastePreferences prefs, {List<Recipe>? oldRecipes}) {
  final basePrompt = AIPrompts.recipeGenerationPrompt
      .replaceAll('{{taste}}', prefs.taste)
      .replaceAll('{{cuisine}}', prefs.cuisine)
      .replaceAll('{{diet}}', prefs.diet)
      .replaceAll('{{maxCookingTime}}', prefs.maxCookingTime.toString());

  if (oldRecipes != null && oldRecipes.isNotEmpty) {
    final oldTitles = oldRecipes.map((r) => r.title).join(", ");

    return """
     $basePrompt

     Avoid repeating these recipes:
     $oldTitles

     Generate NEW recipes that are different from the above.
     """;
  }
  return basePrompt;
}
