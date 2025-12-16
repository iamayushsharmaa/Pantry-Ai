import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/week_label.dart';
import '../../domain/entities/range.dart';
import '../bloc/analytics_bloc.dart';

class AnalyticsRangeSelector extends StatelessWidget {
  final AnalyticsRange selected;

  const AnalyticsRangeSelector({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      children: AnalyticsRange.values.map((range) {
        final isSelected = range == selected;

        return ChoiceChip(
          label: Text(label(range, context)),
          selected: isSelected,
          selectedColor: cs.primary.withOpacity(0.15),
          labelStyle: TextStyle(
            color: isSelected ? cs.primary : cs.onSurface,
            fontWeight: FontWeight.w600,
          ),
          onSelected: (_) {
            context.read<AnalyticsBloc>().add(ChangeRange(range));
          },
        );
      }).toList(),
    );
  }
}
