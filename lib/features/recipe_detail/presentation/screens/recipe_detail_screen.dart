import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_ai/shared/widgets/favorite_button.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/widgets/add_to_cooking_button.dart';
import '../bloc/recipe_detail_bloc.dart';
import '../widgets/difficulty_indicator.dart';
import '../widgets/ingredient_card.dart';
import '../widgets/instruction_step_card.dart';
import '../widgets/missing_ingredient_card.dart';
import '../widgets/missing_ingredient_header.dart';
import '../widgets/recipe_section_header.dart';
import '../widgets/recipe_state_row.dart';
import '../widgets/recipe_tag_row.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe? recipe;
  final String? recipeId;

  const RecipeDetailScreen({super.key, this.recipe, this.recipeId})
    : assert(recipe != null || recipeId != null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
      builder: (context, state) {
        if (state is RecipeDetailLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is RecipeDetailError) {
          return const Scaffold(
            body: Center(child: Text('Failed to load recipe')),
          );
        }

        final recipe = (state as RecipeDetailLoaded).recipe;

        // ⬇⬇⬇ EVERYTHING BELOW IS YOUR ORIGINAL UI (UNCHANGED) ⬇⬇⬇

        return Scaffold(
          backgroundColor: cs.surface,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cs.surface.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: cs.onSurface,
                  size: 22,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              FavoriteButton(recipe: recipe),
              const SizedBox(width: 8),
            ],
          ),
          bottomNavigationBar: AddToCookingAction(recipe: recipe),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Image.network(
                          recipe.imageUrl,
                          fit: BoxFit.cover,
                          cacheWidth: 800,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: cs.surfaceContainerHighest,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: cs.primary,
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => Container(
                            color: cs.surfaceContainerHighest,
                            child: Icon(
                              Icons.restaurant,
                              size: 64,
                              color: cs.onSurface.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              cs.surface.withOpacity(0.9),
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 20),

                    Text(
                      recipe.title,
                      style: textTheme.headlineMedium?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: cs.onSurface,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),

                    RecipeStatsRow(recipe: recipe, colorScheme: cs),
                    const SizedBox(height: 16),

                    RecipeDifficultyIndicator(
                      difficulty: recipe.difficulty,
                      colorScheme: cs,
                    ),

                    if (recipe.cuisine != null || recipe.dietaryInfo != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: RecipeTagsRow(
                          cuisine: recipe.cuisine,
                          dietaryInfo: recipe.dietaryInfo,
                          colorScheme: cs,
                        ),
                      ),

                    const SizedBox(height: 20),

                    if (recipe.description != null)
                      Text(
                        recipe.description!,
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          height: 1.6,
                          color: cs.onSurface.withOpacity(0.8),
                        ),
                      ),

                    const SizedBox(height: 24),

                    RecipeSectionHeader(
                      title: l10n.ingredients_title,
                      count: recipe.ingredients.length,
                      colorScheme: cs,
                    ),
                    const SizedBox(height: 12),

                    ...recipe.ingredients.map(
                      (ing) => IngredientCard(ingredient: ing, colorScheme: cs),
                    ),

                    const SizedBox(height: 20),

                    if (recipe.missingIngredients.isNotEmpty) ...[
                      MissingIngredientsHeader(colorScheme: cs),
                      const SizedBox(height: 8),
                      ...recipe.missingIngredients.map(
                        (m) => MissingIngredientCard(name: m, colorScheme: cs),
                      ),
                      const SizedBox(height: 20),
                    ],

                    Text(
                      l10n.cooking_instructions,
                      style: textTheme.titleLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ...List.generate(recipe.instructions.length, (i) {
                      return InstructionStepCard(
                        step: i + 1,
                        text: recipe.instructions[i],
                        colorScheme: cs,
                      );
                    }),

                    const SizedBox(height: 20),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
