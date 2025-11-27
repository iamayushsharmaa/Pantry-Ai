import '../../shared/models/recipe/taste_preference.dart';

class RecipeListArgs {
  final String imagePath;
  final TastePreferences preferences;

  RecipeListArgs({required this.imagePath, required this.preferences});
}
