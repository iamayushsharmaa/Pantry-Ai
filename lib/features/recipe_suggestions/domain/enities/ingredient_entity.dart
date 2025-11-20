class Ingredient {
  final String name;
  final double? quantity;
  final String? unit;
  final bool isAvailable;

  const Ingredient({
    required this.name,
    this.quantity,
    this.unit,
    required this.isAvailable,
  });
}
