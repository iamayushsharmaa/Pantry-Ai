import 'package:flutter/material.dart' hide Step;

import '../../domain/entities/cooking_step.dart';

class StepDisplay extends StatelessWidget {
  final Step step;
  final bool isCurrent;
  final VoidCallback? onStartTimer;

  const StepDisplay({
    super.key,
    required this.step,
    this.isCurrent = false,
    this.onStartTimer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCurrent ? Theme.of(context).colorScheme.primaryContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              step.instruction,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontSize: 18),
            ),
            if (step.estimatedMinutes > 0 && isCurrent) ...[
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: onStartTimer,
                icon: const Icon(Icons.timer),
                label: Text('Start ${step.estimatedMinutes}min Timer'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
