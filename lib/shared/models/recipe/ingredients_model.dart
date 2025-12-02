import 'package:pantry_ai/shared/models/recipe/recipe.dart';

class IngredientModel extends Ingredient {
  IngredientModel({
    required super.id,
    required super.name,
    required super.quantity,
    required super.unit,
    required super.isAvailable,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      isAvailable: json['isAvailable'] as bool,
    );
  }
}
