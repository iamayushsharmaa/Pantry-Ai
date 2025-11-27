import '../../../features/recipe_suggestions/domain/enities/nutrition_info.dart';

class NutritionInfoModel extends NutritionInfo {
  NutritionInfoModel({
    required super.protein,
    required super.carbs,
    required super.fat,
    required super.fiber,
  });

  factory NutritionInfoModel.fromJson(Map<String, dynamic> json) {
    return NutritionInfoModel(
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
    );
  }
}
