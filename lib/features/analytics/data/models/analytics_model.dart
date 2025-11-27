import 'package:cloud_firestore/cloud_firestore.dart';
import 'most_cook_recipe.dart';

class UserAnalytics {
  final String userId;
  final int totalRecipesCooked;
  final int totalCookingTime;
  final int totalCalories;
  final Map<String, int> favoriteCuisines;
  final double averageDifficulty;
  final List<MostCookedRecipe> mostCookedRecipes;
  final DateTime lastUpdated;

  UserAnalytics({
    required this.userId,
    required this.totalRecipesCooked,
    required this.totalCookingTime,
    required this.totalCalories,
    required this.favoriteCuisines,
    required this.averageDifficulty,
    required this.mostCookedRecipes,
    required this.lastUpdated,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'totalRecipesCooked': totalRecipesCooked,
      'totalCookingTime': totalCookingTime,
      'totalCalories': totalCalories,
      'favoriteCuisines': favoriteCuisines,
      'averageDifficulty': averageDifficulty,
      'mostCookedRecipes': mostCookedRecipes.map((r) => r.toMap()).toList(),
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }

  factory UserAnalytics.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserAnalytics(
      userId: doc.id,
      totalRecipesCooked: data['totalRecipesCooked'] ?? 0,
      totalCookingTime: data['totalCookingTime'] ?? 0,
      totalCalories: data['totalCalories'] ?? 0,
      favoriteCuisines: Map<String, int>.from(data['favoriteCuisines'] ?? {}),
      averageDifficulty: (data['averageDifficulty'] ?? 0.0).toDouble(),
      mostCookedRecipes:
          (data['mostCookedRecipes'] as List?)
              ?.map((r) => MostCookedRecipe.fromMap(r))
              .toList() ??
          [],
      lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
    );
  }
}