import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/recipe/taste_preference.dart';

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
    final l10n = AppLocalizations.of(context)!;


    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outline.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.file(
              File(imagePath),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              cacheWidth: 180,
              cacheHeight: 180,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _PreferenceChip(label: preferences.taste, cs: cs),
                _PreferenceChip(label: preferences.cuisine, cs: cs),
                _PreferenceChip(label: preferences.diet, cs: cs),
                _PreferenceChip(
                  label: "${preferences.maxCookingTime} ${l10n.min}",
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

class _PreferenceChip extends StatelessWidget {
  final String label;
  final ColorScheme cs;

  const _PreferenceChip({required this.label, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cs.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: cs.onPrimaryContainer,
        ),
      ),
    );
  }
}
