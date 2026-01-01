import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class QuestionPage extends StatelessWidget {
  final String title;
  final List<dynamic> options;
  final dynamic selected;
  final Function(dynamic) onSelected;

  const QuestionPage({
    super.key,
    required this.title,
    required this.options,
    this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options.map((option) {
              return OptionChip(
                option: option,
                isSelected: selected == option,
                colorScheme: cs,
                onTap: () => onSelected(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class OptionChip extends StatelessWidget {
  final dynamic option;
  final bool isSelected;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const OptionChip({
    super.key,
    required this.option,
    required this.isSelected,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outline.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              option is int ? "< $option ${l10n.min}" : option.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
