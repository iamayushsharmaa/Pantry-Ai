import 'package:flutter/material.dart';

class EmptyAnalyticsState extends StatelessWidget {
  const EmptyAnalyticsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, size: 72, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'No analytics yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Start cooking recipes to see insights.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
