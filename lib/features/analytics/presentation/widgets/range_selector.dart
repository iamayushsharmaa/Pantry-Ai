import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/range.dart';
import '../bloc/analytics_bloc.dart';

class AnalyticsRangeSelector extends StatelessWidget {
  final AnalyticsRange selected;

  const AnalyticsRangeSelector({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: AnalyticsRange.values.map((range) {
        final isSelected = range == selected;

        return ChoiceChip(
          label: Text(_label(range)),
          selected: isSelected,
          onSelected: (_) {
            context.read<AnalyticsBloc>().add(ChangeRange(range));
          },
        );
      }).toList(),
    );
  }

  String _label(AnalyticsRange range) {
    switch (range) {
      case AnalyticsRange.week:
        return 'This Week';
      case AnalyticsRange.month:
        return 'This Month';
      case AnalyticsRange.all:
      default:
        return 'All Time';
    }
  }
}
