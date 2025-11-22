import '../../features/recipe_suggestions/domain/enities/taste_preference_entity.dart';

class RecipeListArgs {
  final String imagePath;
  final TastePreferences preferences;

  RecipeListArgs({required this.imagePath, required this.preferences});
}
