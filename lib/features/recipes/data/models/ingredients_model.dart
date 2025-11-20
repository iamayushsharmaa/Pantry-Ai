class Ingredient {
  final String name;
  final double? quantity; // optional: 2.0
  final String? unit;     // optional: "grams", "pieces"
  final bool isAvailable; // detected from user image

  Ingredient({
    required this.name,
    this.quantity,
    this.unit,
    required this.isAvailable,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: json['quantity']?.toDouble(),
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
}
