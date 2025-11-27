class MostCookedRecipe {
  final String recipeId;
  final String title;
  final String imageUrl;
  final int count;

  MostCookedRecipe({
    required this.recipeId,
    required this.title,
    required this.imageUrl,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipeId': recipeId,
      'title': title,
      'imageUrl': imageUrl,
      'count': count,
    };
  }

  factory MostCookedRecipe.fromMap(Map<String, dynamic> map) {
    return MostCookedRecipe(
      recipeId: map['recipeId'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      count: map['count'],
    );
  }
}
