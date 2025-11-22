import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String title;
  final List<dynamic> options;
  final dynamic selected;
  final Function(dynamic) onSelected;

  const QuestionWidget({
    super.key,
    required this.title,
    required this.options,
    this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: cs.onBackground,
            ),
          ),

          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: options.map((o) {
              final isSelected = selected == o;

              return ChoiceChip(
                selected: isSelected,
                onSelected: (_) => onSelected(o),

                label: Text(
                  o is int ? "< $o min" : o,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? cs.onPrimary
                        : cs.onSurface.withOpacity(0.85),
                  ),
                ),

                backgroundColor: cs.surface,
                selectedColor: cs.primary,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? cs.primary
                        : cs.outlineVariant.withOpacity(0.4),
                    width: 1.2,
                  ),
                ),

                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                elevation: isSelected ? 3 : 0,
                shadowColor: cs.primary.withOpacity(0.3),

                labelPadding: EdgeInsets.zero,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
