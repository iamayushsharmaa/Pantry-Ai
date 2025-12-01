import 'package:flutter/material.dart';

class CookingProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double ingredientsProgress;

  const CookingProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.ingredientsProgress,
  });

  @override
  Widget build(BuildContext context) {
    final stepProgress = (currentStep + 1) / totalSteps;
    return Column(
      children: [
        LinearProgressIndicator(
          value: stepProgress,
          backgroundColor: Colors.grey[300],
        ),
        Text(
          '${currentStep + 1}/$totalSteps steps • ${(ingredientsProgress * 100).toInt()}% ingredients ready',
        ),
      ],
    );
  }
}
