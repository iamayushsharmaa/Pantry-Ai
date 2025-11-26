import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/stats_data_model.dart';
import 'chart_card.dart';

class DifficultyChartCard extends StatelessWidget {
  final List<DifficultyData> difficultyData;

  const DifficultyChartCard({super.key, required this.difficultyData});

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: 'Recipe Difficulty',
      icon: Icons.pie_chart,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 35,
                  sections: difficultyData.map((data) {
                    return PieChartSectionData(
                      value: data.value.toDouble(),
                      title: '${data.value}%',
                      color: data.color,
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: difficultyData.map((data) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LegendItem(
                  label: data.name,
                  color: data.color,
                  value: '${data.value}%',
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final String value;

  const LegendItem({
    required this.label,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
