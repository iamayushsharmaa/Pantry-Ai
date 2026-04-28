import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favourite_bloc/favorites_bloc.dart';
import '../bloc/saved_bloc/saved_bloc.dart';
import '../widgets/cooking_list_section.dart';
import '../widgets/favourite_section.dart';
import '../widgets/full_saved_empty_widget.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Saved',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favState) {
                  return BlocBuilder<SavedBloc, SavedState>(
                    builder: (context, savedState) {
                      final isLoading =
                          favState.isLoading &&
                          favState.favorites.isEmpty &&
                          savedState.savedRecipes.isEmpty;

                      final isEmpty =
                          !favState.isLoading &&
                          favState.favorites.isEmpty &&
                          savedState.savedRecipes.isEmpty;

                      // Loading
                      if (isLoading) {
                        return const SizedBox(
                          height: 300,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (isEmpty) {
                        return SavedEmptyState(colorScheme: cs);
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (favState.favorites.isNotEmpty) ...[
                            FavoritesSection(
                              favorites: favState.favorites,
                              colorScheme: cs,
                            ),
                            const SizedBox(height: 24),
                          ],

                          if (savedState.savedRecipes.isNotEmpty)
                            CookingListSection(
                              recipes: savedState.savedRecipes,
                              colorScheme: cs,
                            ),

                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
