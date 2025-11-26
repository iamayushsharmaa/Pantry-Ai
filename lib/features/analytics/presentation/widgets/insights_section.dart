import 'package:flutter/material.dart';

class InsightsSection extends StatelessWidget {
  const InsightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InsightCard(
          emoji: '💡',
          title: 'Smart Insight',
          description:
              'You cook 40% more on weekends! Consider meal prepping on Sundays.',
          gradient: [Color(0xFF4A90E2), Color(0xFF357ABD)],
        ),
        SizedBox(height: 12),
        InsightCard(
          emoji: '🎯',
          title: 'Goal Progress',
          description:
              "You're 85% towards your monthly goal of 45 recipes. Keep going!",
          gradient: [Color(0xFF00A87D), Color(0xFF00C896)],
        ),
        SizedBox(height: 12),
        InsightCard(
          emoji: '⭐',
          title: 'Achievement',
          description:
              "You've unlocked 'Master Chef' badge for cooking 100+ recipes!",
          gradient: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
        ),
      ],
    );
  }
}

class InsightCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final List<Color> gradient;

  const InsightCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
