import 'package:pantry_ai/shared/models/recipe/recipe.dart';

class IngredientModel extends Ingredient {
  IngredientModel({
    required super.id,
    required super.name,
    required super.quantity,
    required super.unit,
    required super.isAvailable,
  });

  factory IngredientModel.fromJson(
    Map<String, dynamic> json, {
    String fallbackId = '',
  }) {
    return IngredientModel(
      id: json['id']?.toString().isNotEmpty == true
          ? json['id'].toString()
          : fallbackId,
      name: json['name']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit']?.toString() ?? '',
      isAvailable: json['isAvailable'] as bool? ?? false,
    );
  }
}
