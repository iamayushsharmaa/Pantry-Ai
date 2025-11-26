import 'dart:ui';

class AnalyticConstants {
  static const rankColors = [
    Color(0xFFFBBF24), // Gold
    Color(0xFF9CA3AF), // Silver
    Color(0xFFEA580C), // Bronze
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
