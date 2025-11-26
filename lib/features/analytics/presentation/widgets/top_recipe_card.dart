import 'package:flutter/material.dart';
import 'package:pantry_ai/core/constant/analytic_constants.dart';

import '../../domain/entities/stats_data_model.dart';
import 'chart_card.dart';

class TopRecipesCard extends StatelessWidget {
  final List<TopRecipe> topRecipes;

  const TopRecipesCard({super.key, required this.topRecipes});

  @override
  Widget build(BuildContext context) {
    final maxCount = topRecipes.first.count;

    return ChartCard(
      title: 'Most Cooked Recipes',
      icon: Icons.restaurant_menu,
      child: Column(
        children: topRecipes.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: RecipeRankItem(
              index: entry.key,
              recipe: entry.value,
              maxCount: maxCount,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class RecipeRankItem extends StatelessWidget {
  final int index;
  final TopRecipe recipe;
  final int maxCount;

  const RecipeRankItem({
    required this.index,
    required this.recipe,
    required this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    final rankColors = AnalyticConstants.rankColors;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: index < 3
                ? rankColors[index]
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            recipe.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: recipe.count / maxCount,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF00A87D)),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 24,
          child: Text(
            '${recipe.count}',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
