import '../../../features/recipe_suggestions/domain/enities/ingredient_entity.dart';

class IngredientModel extends Ingredient {
  IngredientModel({
    required super.name,
    required super.quantity,
    required super.unit,
    required super.isAvailable,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      isAvailable: json['isAvailable'] as bool,
    );
  }
}
