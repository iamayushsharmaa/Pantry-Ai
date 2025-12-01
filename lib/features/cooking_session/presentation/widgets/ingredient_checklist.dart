import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../bloc/cooking_session_bloc.dart';

class IngredientChecklist extends StatelessWidget {
  final List<Ingredient> ingredients;
  final int servings;
  final Map<String, bool> checklist; // From state

  const IngredientChecklist({
    super.key,
    required this.ingredients,
    required this.servings,
    required this.checklist,
  });

  @override
  Widget build(BuildContext context) {
    final scaledIngredients = _scaleIngredients(ingredients, servings);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients (${scaledIngredients.length} checked)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: scaledIngredients.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final ing = scaledIngredients[index];
            final checked =
                checklist[ing.name] ?? false; // Use name as ID for simplicity
            return CheckboxListTile(
              title: Text(
                '${ing.name} (${ing.quantity.toStringAsFixed(1)} ${ing.unit})',
              ),
              value: checked,
              onChanged: (value) => context.read<CookingBloc>().add(
                ToggleIngredientEvent(
                  ingredientId: ing.name,
                  isChecked: value ?? false,
                ),
              ),
              secondary: Icon(
                checked ? Icons.check_circle : Icons.circle_outlined,
                color: checked ? Colors.green : null,
              ),
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        ),
      ],
    );
  }

  List<Ingredient> _scaleIngredients(List<Ingredient> orig, int newServings) {
    final origServings = 4;
    final scale = newServings / origServings;
    return orig
        .map(
          (i) => Ingredient(
            name: i.name,
            quantity: i.quantity * scale,
            unit: i.unit,
            isAvailable: i.isAvailable,
          ),
        )
        .toList();
  }
}
