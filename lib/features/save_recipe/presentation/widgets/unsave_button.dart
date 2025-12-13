import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/saved_bloc.dart';

class UnsaveButton extends StatelessWidget {
  final String recipeId;

  const UnsaveButton({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.bookmark_remove_rounded),
      onPressed: () {
        final recipe = context
            .read<SavedBloc>()
            .state
            .savedRecipes
            .firstWhere((e) => e.recipeId == recipeId)
            .recipe;

        context.read<SavedBloc>().add(ToggleSavedEvent(recipe));
      },
    );
  }
}
