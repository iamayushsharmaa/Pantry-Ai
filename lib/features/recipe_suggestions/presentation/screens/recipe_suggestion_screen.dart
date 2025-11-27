import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/bloc/recipe_bloc.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/widgets/suggestions/app_bar.dart';

import '../widgets/suggestions/preference_summary_widget.dart';
import '../widgets/suggestions/recipe_card_widget.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.isLoading && state.recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(strokeWidth: 3, color: cs.primary),
                  const SizedBox(height: 20),
                  Text(
                    'Preparing your recipes...',
                    style: TextStyle(
                      color: cs.onSurface.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state.imagePath == null || state.preferences == null) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: cs.primary,
              ),
            );
          }

          final recipes = [];

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SuggestionAppBar(colorScheme: cs),

              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: RepaintBoundary(
                        child: PreferenceSummaryWidget(
                          imagePath: state.imagePath!,
                          preferences: state.preferences!,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "${recipes.length} recipes",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: cs.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Suggested Recipes",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: cs.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Recipe Cards
                    ...List.generate(recipes.length, (index) {
                      final recipe = recipes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: RepaintBoundary(
                          child: RecipeCard(
                            recipe: recipe,
                            colorScheme: cs,
                            onTap: () => context.pushNamed(
                              'recipeDetails',
                              extra: recipe,
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),

                    // Load More Button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [cs.primary, cs.primary.withOpacity(0.85)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: cs.primary.withOpacity(0.18),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            context.read<RecipeBloc>().add(
                              FetchMoreRecipesRequested(),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.refresh_rounded,
                                  color: cs.onPrimary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Load More Recipes",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Loading Indicator
                    if (state.isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 2.8,
                              color: cs.primary,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Loading more recipes...",
                              style: TextStyle(
                                color: cs.onSurface.withOpacity(0.6),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
