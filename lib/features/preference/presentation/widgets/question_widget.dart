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
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
              letterSpacing: -0.3,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose one option',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.4),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.6,
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return OptionChip(
                option: option,
                isSelected: selected == option,
                colorScheme: cs,
                onTap: () => onSelected(option),
              );
            },
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
    final label = option is int ? '< $option ${l10n.min}' : option.toString();

    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outline.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSelected) ...[
                  Icon(
                    Icons.check_rounded,
                    size: 15,
                    color: colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface.withOpacity(0.75),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
