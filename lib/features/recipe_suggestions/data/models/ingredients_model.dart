import '../../domain/enities/ingredient_entity.dart';

class IngredientModel extends Ingredient {
  IngredientModel({
    required super.name,
    super.quantity,
    super.unit,
    required super.isAvailable,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'],
      quantity: json['quantity'] == null
          ? null
          : (json['quantity'] as num).toDouble(),
      unit: json['unit'],
      isAvailable: json['isAvailable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'unit': unit,
    'isAvailable': isAvailable,
  };

  factory IngredientModel.fromEntity(Ingredient entity) {
    return IngredientModel(
      name: entity.name,
      quantity: entity.quantity,
      unit: entity.unit,
      isAvailable: entity.isAvailable,
    );
  }

  Ingredient toEntity() {
    return Ingredient(
      name: name,
      quantity: quantity,
      unit: unit,
      isAvailable: isAvailable,
    );
  }
}
