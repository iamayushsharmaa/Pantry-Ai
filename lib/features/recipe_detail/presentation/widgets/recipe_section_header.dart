import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class RecipeSectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final ColorScheme colorScheme;

  const RecipeSectionHeader({
    super.key,
    required this.title,
    required this.count,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "$count ${l10n.items}",
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
