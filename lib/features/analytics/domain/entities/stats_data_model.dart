import 'package:flutter/cupertino.dart';

class StatData {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final String? trend;
  final List<Color> gradient;

  const StatData({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    this.trend,
    required this.gradient,
  });
}

class WeeklyData {
  final String day;
  final int recipes;

  const WeeklyData({required this.day, required this.recipes});
}

class DifficultyData {
  final String name;
  final int value;
  final Color color;

  const DifficultyData({
    required this.name,
    required this.value,
    required this.color,
  });
}

class TopRecipe {
  final String name;
  final int count;

  const TopRecipe({required this.name, required this.count});
}
