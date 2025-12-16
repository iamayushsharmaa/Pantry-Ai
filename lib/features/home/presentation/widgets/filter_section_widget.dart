import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class FilterSection extends StatelessWidget {
  final ColorScheme colorScheme;
  final String selectedFilter;
  final String selectedSort;
  final Function(String) onFilterChanged;
  final Function(String) onSortChanged;

  const FilterSection({
    required this.colorScheme,
    required this.selectedFilter,
    required this.selectedSort,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 50,
      padding: const EdgeInsets.only(bottom: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          FilterChip(
            colorScheme: colorScheme,
            label: l10n.all,
            isSelected: selectedFilter == 'All',
            onTap: () => onFilterChanged('All'),
          ),
          const SizedBox(width: 8),
          FilterChip(
            colorScheme: colorScheme,
            label: l10n.easy,
            isSelected: selectedFilter == 'Easy',
            onTap: () => onFilterChanged('Easy'),
          ),
          const SizedBox(width: 8),
          FilterChip(
            colorScheme: colorScheme,
            label: l10n.medium,
            isSelected: selectedFilter == 'Medium',
            onTap: () => onFilterChanged('Medium'),
          ),
          const SizedBox(width: 8),
          FilterChip(
            colorScheme: colorScheme,
            label: l10n.hard,
            isSelected: selectedFilter == 'Hard',
            onTap: () => onFilterChanged('Hard'),
          ),
          const SizedBox(width: 16),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: colorScheme.outline.withOpacity(0.2),
          ),
          const SizedBox(width: 16),
          SortDropdown(
            colorScheme: colorScheme,
            selectedSort: selectedSort,
            onChanged: onSortChanged,
          ),
        ],
      ),
    );
  }
}

class FilterChip extends StatelessWidget {
  final ColorScheme colorScheme;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChip({
    required this.colorScheme,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outline.withOpacity(0.2),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class SortDropdown extends StatelessWidget {
  final ColorScheme colorScheme;
  final String selectedSort;
  final Function(String) onChanged;

  const SortDropdown({
    required this.colorScheme,
    required this.selectedSort,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: DropdownButton<String>(
        value: selectedSort,
        underline: const SizedBox(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: colorScheme.onSurface,
          size: 20,
        ),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        items: ['Recent', 'Name A-Z', 'Cook Time', 'Difficulty']
            .map((sort) => DropdownMenuItem(value: sort, child: Text(sort)))
            .toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }
}
