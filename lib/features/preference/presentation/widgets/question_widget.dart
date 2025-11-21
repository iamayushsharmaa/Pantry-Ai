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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: options.map((o) {
              return ChoiceChip(
                label: Text(
                  o is int ? "< $o min" : o,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                selected: selected == o,
                onSelected: (_) => onSelected(o),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
