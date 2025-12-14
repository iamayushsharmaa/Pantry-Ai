import 'package:flutter/material.dart';

import '../../domain/entities/analytics_data.dart';
import '../widgets/app_bar.dart';
import '../widgets/difficulty_char_card.dart';
import '../widgets/insights_section.dart';
import '../widgets/stats_grid.dart';
import '../widgets/top_recipe_card.dart';
import '../widgets/weekly_chart_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedRange = 'week';


  // @override
  // void initState() {
  //   super.initState();
  //   _analyticsData = AnalyticsData.mock();
  // }

  void _onRangeChanged(String range) {
    setState(() => _selectedRange = range);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,

      body: CustomScrollView(
        slivers: [
          AnalyticsAppBar(
            selectedRange: _selectedRange,
            onRangeChanged: _onRangeChanged,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                StatsGrid(stats: _analyticsData.stats),
                const SizedBox(height: 24),
                WeeklyChartCard(weeklyData: _analyticsData.weeklyData),
                const SizedBox(height: 24),
                DifficultyChartCard(
                  difficultyData: _analyticsData.difficultyData,
                ),
                const SizedBox(height: 24),
                TopRecipesCard(topRecipes: _analyticsData.topRecipes),
                const SizedBox(height: 24),
                const InsightsSection(),
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
