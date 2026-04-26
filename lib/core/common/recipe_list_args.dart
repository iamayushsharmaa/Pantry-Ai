import '../../shared/models/recipe/taste_preference.dart';

class RecipeListArgs {
  final String imagePath;
  final TastePreferences preferences;

  const RecipeListArgs({required this.imagePath, required this.preferences});
}
