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
    return Column();
  }

}
