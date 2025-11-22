import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/enities/taste_preference_entity.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(imagePath),
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildChip(preferences.taste),
              _buildChip(preferences.cuisine),
              _buildChip(preferences.diet),
              _buildChip("${preferences.maxCookingTime} min"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
