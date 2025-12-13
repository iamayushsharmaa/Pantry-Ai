import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/saved_bloc.dart';
import '../widgets/empty_saved_state.dart';
import '../widgets/save_loading.dart';
import '../widgets/saved_recipe_tile.dart';

class SavedRecipesScreen extends StatelessWidget {
  const SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text(
          'Saved Recipes',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: cs.surface,
      ),
      body: BlocBuilder<SavedBloc, SavedState>(
        buildWhen: (p, c) =>
            p.savedRecipes != c.savedRecipes || p.isLoading != c.isLoading,
        builder: (context, state) {
          if (state.isLoading) {
            return const SavedLoading();
          }

          if (state.savedRecipes.isEmpty) {
            return const EmptySavedState();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.savedRecipes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return SavedRecipeTile(saved: state.savedRecipes[index]);
            },
          );
        },
      ),
    );
  }
}
