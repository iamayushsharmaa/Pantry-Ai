import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/bloc/recipe_bloc.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/widgets/preference_summary_widget.dart';

import '../../../../core/constant/constants.dart';
import '../widgets/recipe_card_widget.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.background,

      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.isLoading && state.recipes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.imagePath == null || state.preferences == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final recipes = dummyRecipes;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 50, 12, 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: cs.onBackground,
                          size: 26,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Recommended Dishes",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: cs.onBackground,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Smart recipes based on your scan",
                              style: TextStyle(
                                fontSize: 14,
                                color: cs.onBackground.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 40),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PreferenceSummaryWidget(
                    imagePath: state.imagePath!,
                    preferences: state.preferences!,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Text(
                    "Suggested Recipes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: cs.onBackground,
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // ⭐ RECIPE LIST
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final recipe = recipes[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.95, end: 1),
                      duration: Duration(milliseconds: 280 + (index * 70)),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Transform.scale(scale: value, child: child);
                      },
                      child: RecipeCard(
                        recipe: recipe,
                        onTap: () =>
                            context.pushNamed('recipeDetails', extra: recipe),
                      ),
                    ),
                  );
                }, childCount: recipes.length),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.read<RecipeBloc>().add(
                        FetchMoreRecipesRequested(),
                      );
                    },
                    child: const Text(
                      "More Recipes",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),

              if (state.isLoading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        },
      ),
    );
  }
}
