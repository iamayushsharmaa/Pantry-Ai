import '../../../../core/constant/constants.dart';
import '../../domain/enities/taste_preference_entity.dart';

String buildPrompt(TastePreferences prefs) {
  return Constants.prompt
      .replaceAll('{{taste}}', prefs.taste)
      .replaceAll('{{cuisine}}', prefs.cuisine)
      .replaceAll('{{diet}}', prefs.diet)
      .replaceAll('{{maxCookingTime}}', prefs.maxCookingTime.toString());
}
