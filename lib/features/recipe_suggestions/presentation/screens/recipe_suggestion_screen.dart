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
      backgroundColor: cs.surface,
      extendBodyBehindAppBar: true,
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.isLoading && state.recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(strokeWidth: 3, color: cs.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Preparing your recipes...',
                    style: TextStyle(
                      color: cs.onSurface.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state.imagePath == null || state.preferences == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final recipes = dummyRecipes;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 140,
                floating: false,
                pinned: true,
                elevation: 0,
                backgroundColor: cs.surface,
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: cs.onSurface,
                    size: 20,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Recommended Dishes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Smart recipes based on your scan",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: cs.onSurface.withOpacity(0.6),
                          letterSpacing: 0,
                        ),
                      ),
                    ],
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          cs.primaryContainer.withOpacity(0.3),
                          cs.surface,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: RepaintBoundary(
                        child: PreferenceSummaryWidget(
                          imagePath: state.imagePath!,
                          preferences: state.preferences!,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                  ],
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final recipe = recipes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: RepaintBoundary(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: cs.shadow.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: RecipeCard(
                            recipe: recipe,
                            onTap: () => context.pushNamed(
                              'recipeDetails',
                              extra: recipe,
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: recipes.length),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // OPTIMIZED LOAD MORE BUTTON
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [cs.primary, cs.primary.withOpacity(0.85)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: cs.primary.withOpacity(0.18),
                              blurRadius: 8, // reduced from 12 → GPU cheaper
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
                    ),

                    if (state.isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 2.8, // slightly lighter
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

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
