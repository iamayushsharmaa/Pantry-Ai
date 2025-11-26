import 'package:pantry_ai/core/theme/colors.dart';

class AnalyticConstants {
  static const rankColors = [
    AppColors.gold,
    AppColors.silver,
    AppColors.bronze,
  ];

  static const List<Map<String, dynamic>> weeklyData = [
    {'day': 'Mon', 'recipes': 2},
    {'day': 'Tue', 'recipes': 1},
    {'day': 'Wed', 'recipes': 3},
    {'day': 'Thu', 'recipes': 2},
    {'day': 'Fri', 'recipes': 4},
    {'day': 'Sat', 'recipes': 3},
    {'day': 'Sun', 'recipes': 2},
  ];

  static const List<Map<String, dynamic>> topRecipes = [
    {'name': 'Pasta Carbonara', 'count': 12},
    {'name': 'Chicken Stir Fry', 'count': 10},
    {'name': 'Greek Salad', 'count': 9},
    {'name': 'Tacos', 'count': 8},
    {'name': 'Pad Thai', 'count': 7},
  ];

  static const weekType = ['week', 'month', 'year'];
}
