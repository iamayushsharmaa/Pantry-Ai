import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class MissingIngredientsHeader extends StatelessWidget {
  final ColorScheme colorScheme;

  const MissingIngredientsHeader({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Icon(Icons.warning_rounded, color: colorScheme.error, size: 20),
        const SizedBox(width: 8),
        Text(
          l10n.missing_ingredients_title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.error,
          ),
        ),
      ],
    );
  }
}
