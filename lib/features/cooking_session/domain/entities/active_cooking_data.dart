import '../../../../shared/models/recipe/recipe.dart';
import 'cooking_session_entity.dart';

class ActiveCookingData {
  final CookingSession session;
  final Recipe recipe;

  ActiveCookingData({required this.session, required this.recipe});
}
