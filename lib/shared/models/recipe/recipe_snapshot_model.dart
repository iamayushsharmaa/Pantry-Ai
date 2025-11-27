import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_ai/shared/models/recipe/recipe.dart';


class RecipeSnapshot {
  final String title;
  final String imageUrl;
  final int difficulty;
  final int cookingTime;
  final int calories;
  final String cuisine;
  final List<String> tags;

  RecipeSnapshot({
    required this.title,
    required this.imageUrl,
    required this.difficulty,
    required this.cookingTime,
    required this.calories,
    required this.cuisine,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'difficulty': difficulty,
      'cookingTime': cookingTime,
      'calories': calories,
      'cuisine': cuisine,
      'tags': tags,
    };
  }

  factory RecipeSnapshot.fromJson(Map<String, dynamic> map) {
    return RecipeSnapshot(
      title: map['title'],
      imageUrl: map['imageUrl'],
      difficulty: map['difficulty'],
      cookingTime: map['cookingTime'],
      calories: map['calories'],
      cuisine: map['cuisine'],
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  factory RecipeSnapshot.fromRecipe(Recipe recipe) {
    return RecipeSnapshot(
      title: recipe.title,
      imageUrl: recipe.imageUrl,
      difficulty: recipe.difficulty,
      cookingTime: recipe.cookingTime,
      calories: recipe.calories,
      cuisine: recipe.cuisine,
      tags: recipe.tags,
    );
  }

  factory RecipeSnapshot.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RecipeSnapshot.fromJson(data);
  }
}
