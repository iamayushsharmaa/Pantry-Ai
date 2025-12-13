import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/show_snackbar.dart';
import '../../features/save_recipe/presentation/bloc/saved_bloc.dart';
import '../models/recipe/recipe.dart';

class AddToCookingAction extends StatelessWidget {
  final Recipe recipe;

  const AddToCookingAction({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocSelector<SavedBloc, SavedState, bool>(
      selector: (state) => state.savedRecipeIds.contains(recipe.id),
      builder: (context, isAdded) {
        return Container(
          decoration: BoxDecoration(
            color: cs.surface,
            boxShadow: [
              BoxShadow(
                color: cs.shadow.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAdded ? cs.surfaceVariant : cs.primary,
                  foregroundColor: isAdded ? cs.onSurface : cs.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: Icon(
                  isAdded
                      ? Icons.check_circle_rounded
                      : Icons.restaurant_menu_rounded,
                  size: 22,
                ),
                label: Text(
                  isAdded ? 'Added to cooking' : 'Add to cooking',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  context.read<SavedBloc>().add(ToggleSavedEvent(recipe));

                  showSnackBar(
                    context,
                    isAdded
                        ? 'Removed from cooking list'
                        : 'Added to cooking 🍳',
                    cs,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
