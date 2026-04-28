import 'package:flutter/material.dart';

class SavedEmptyState extends StatelessWidget {
  final ColorScheme colorScheme;

  const SavedEmptyState({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 80, 32, 0),
      child: Column(
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 56,
            color: colorScheme.onSurface.withOpacity(0.15),
          ),
          const SizedBox(height: 16),
          Text(
            'Nothing saved yet',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Recipes you favorite or add to your\ncooking list will appear here.',
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurface.withOpacity(0.35),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
