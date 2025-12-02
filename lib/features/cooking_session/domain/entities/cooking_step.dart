class CookingStep {
  final int index;
  final String title;
  final String description;
  final int? estimatedMinutes;
  final String? imageUrl;

  const CookingStep({
    required this.index,
    required this.title,
    required this.description,
    this.estimatedMinutes,
    this.imageUrl,
  });
}
