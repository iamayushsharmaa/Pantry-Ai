class RecipeUtils {
  static double getScaleFactor(int _servings, int recipeServings) {
    return _servings / recipeServings;
  }

  static String scaleQuantity(
    String quantity,
    int _servings,
    int recipeServings,
  ) {
    final regex = RegExp(r'(\d+(?:\.\d+)?)\s*(.*)');
    final match = regex.firstMatch(quantity);

    if (match != null) {
      final value = double.parse(match.group(1)!);
      final unit = match.group(2) ?? '';
      final scaled = value * getScaleFactor(_servings, recipeServings);

      if (scaled == scaled.toInt()) {
        return '${scaled.toInt()} $unit'.trim();
      } else {
        return '${scaled.toStringAsFixed(1)} $unit'.trim();
      }
    }
    return quantity;
  }
}
