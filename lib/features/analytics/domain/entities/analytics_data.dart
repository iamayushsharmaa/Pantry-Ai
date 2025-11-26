import 'package:flutter/material.dart';
import 'package:pantry_ai/features/analytics/domain/entities/stats_data_model.dart';

class AnalyticsData {
  final List<StatData> stats;
  final List<WeeklyData> weeklyData;
  final List<DifficultyData> difficultyData;
  final List<TopRecipe> topRecipes;

  const AnalyticsData({
    required this.stats,
    required this.weeklyData,
    required this.difficultyData,
    required this.topRecipes,
  });

  factory AnalyticsData.mock() {
    return AnalyticsData(
      stats: [
        StatData(
          icon: Icons.restaurant,
          title: 'Total Recipes',
          value: '127',
          subtitle: 'This month: 38',
          trend: '+23%',
          gradient: const [Color(0xFF00A87D), Color(0xFF008C6A)],
        ),
        StatData(
          icon: Icons.local_fire_department,
          title: 'Cooking Streak',
          value: '12 days',
          subtitle: 'Keep it going!',
          trend: '+5',
          gradient: const [Color(0xFFFF6B6B), Color(0xFFFF5252)],
        ),
        StatData(
          icon: Icons.access_time,
          title: 'Avg. Time',
          value: '35 min',
          subtitle: 'Per recipe',
          gradient: const [Color(0xFF4A90E2), Color(0xFF357ABD)],
        ),
        StatData(
          icon: Icons.emoji_events,
          title: 'Completion',
          value: '92%',
          subtitle: 'Finished',
          trend: '+8%',
          gradient: const [Color(0xFF00A87D), Color(0xFF00C896)],
        ),
      ],
      weeklyData: [
        WeeklyData(day: 'Mon', recipes: 2),
        WeeklyData(day: 'Tue', recipes: 1),
        WeeklyData(day: 'Wed', recipes: 3),
        WeeklyData(day: 'Thu', recipes: 2),
        WeeklyData(day: 'Fri', recipes: 4),
        WeeklyData(day: 'Sat', recipes: 3),
        WeeklyData(day: 'Sun', recipes: 2),
      ],
      difficultyData: [
        DifficultyData(name: 'Easy', value: 45, color: Color(0xFF00A87D)),
        DifficultyData(name: 'Medium', value: 35, color: Color(0xFFFFA726)),
        DifficultyData(name: 'Hard', value: 20, color: Color(0xFFFF6B6B)),
      ],
      topRecipes: [
        TopRecipe(name: 'Pasta Carbonara', count: 12),
        TopRecipe(name: 'Chicken Stir Fry', count: 10),
        TopRecipe(name: 'Greek Salad', count: 9),
        TopRecipe(name: 'Tacos', count: 8),
        TopRecipe(name: 'Pad Thai', count: 7),
      ],
    );
  }

  factory AnalyticsData.fromFirebase(Map<String, dynamic> data) {
    return AnalyticsData.mock();
  }
}
