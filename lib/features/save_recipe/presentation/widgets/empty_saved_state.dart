import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class EmptySavedState extends StatelessWidget {
  const EmptySavedState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 72, color: cs.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              l10n.no_saved_recipes,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.save_recipes_to_find_them_here_later,
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
