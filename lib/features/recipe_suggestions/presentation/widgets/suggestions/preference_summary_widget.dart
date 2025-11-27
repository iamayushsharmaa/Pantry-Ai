import 'dart:io';

import 'package:flutter/material.dart';

import '../../../domain/enities/taste_preference_entity.dart';

class PreferenceSummaryWidget extends StatelessWidget {
  final String imagePath;
  final TastePreferences preferences;

  const PreferenceSummaryWidget({
    super.key,
    required this.imagePath,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outline.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.file(
                File(imagePath),
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                PreferenceChip(label: preferences.taste, cs: cs),
                PreferenceChip(label: preferences.cuisine, cs: cs),
                PreferenceChip(label: preferences.diet, cs: cs),
                PreferenceChip(
                  label: "${preferences.maxCookingTime} min",
                  cs: cs,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PreferenceChip extends StatelessWidget {
  final String label;
  final ColorScheme cs;

  const PreferenceChip({super.key, required this.label, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: cs.surfaceContainerHighest.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
