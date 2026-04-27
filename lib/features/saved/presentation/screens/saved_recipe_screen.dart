import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favourite_bloc/favorites_bloc.dart';
import '../bloc/saved_bloc/saved_bloc.dart';
import '../widgets/cooking_list_section.dart';
import '../widgets/favourite_section.dart';
import '../widgets/saved_empty_section.dart';

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
                      final bothLoading =
                          favState.isLoading &&
                          favState.favorites.isEmpty &&
                          savedState.savedRecipes.isEmpty;

                      if (bothLoading) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),


            SliverToBoxAdapter(
              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  if (state.isLoading || state.favorites.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  if (state.favorites.isEmpty) {
                    return EmptySection(
                      icon: Icons.favorite_border_rounded,
                      message: 'No favorites yet',
                      subtitle: 'Tap ♥ on any recipe to save it here',
                      colorScheme: cs,
                    );
                  }

                  return FavoritesSection(
                    favorites: state.favorites,
                    colorScheme: cs,
                  );
                },
              ),
            ),

            SliverToBoxAdapter(
              child: BlocBuilder<SavedBloc, SavedState>(
                builder: (context, state) {
                  if (state.savedRecipes.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return CookingListSection(
                    recipes: state.savedRecipes,
                    colorScheme: cs,
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
