import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class MissingIngredientsHeader extends StatelessWidget {
  final ColorScheme colorScheme;
  final int count;

  const MissingIngredientsHeader({
    super.key,
    required this.colorScheme,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: colorScheme.error,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.missing_ingredients_title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "$count items",
            style: TextStyle(
              color: colorScheme.error,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
