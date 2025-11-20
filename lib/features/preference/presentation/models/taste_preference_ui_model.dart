class TastePreferencesUi {
  final String taste;
  final String cuisine;
  final String diet; // veg vegan, non veg, any
  final int maxCookingTime;

  TastePreferencesUi({
    required this.taste,
    required this.cuisine,
    required this.diet,
    required this.maxCookingTime,
  });

  Map<String, dynamic> toJson() => {
    "taste": taste,
    "cuisine": cuisine,
    "diet": diet,
    "maxCookingTime": maxCookingTime,
  };
}
