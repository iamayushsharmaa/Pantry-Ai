import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/widgets/add_to_cooking_button.dart';
import '../../../../shared/widgets/favorite_button.dart';
import '../bloc/recipe_detail_bloc.dart';
import '../widgets/difficulty_indicator.dart';
import '../widgets/image_widget.dart';
import '../widgets/ingredient_card.dart';
import '../widgets/instruction_step_card.dart';
import '../widgets/missing_ingredient_card.dart';
import '../widgets/missing_ingredient_header.dart';
import '../widgets/recipe_section_header.dart';
import '../widgets/recipe_state_row.dart';
import '../widgets/recipe_tag_row.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
      builder: (context, state) {
        if (state is RecipeDetailInitial || state is RecipeDetailLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is RecipeDetailError) {
          return const Scaffold(
            body: Center(child: Text('Failed to load recipe')),
          );
        }

        if (state is RecipeDetailLoaded) {
          final recipe = state.recipe;
          return _buildLoaded(context, recipe);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoaded(BuildContext context, Recipe recipe) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: cs.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: AppBarButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () => Navigator.pop(context),
            cs: cs,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FavoriteAppBarButton(
              recipe: recipe,
              cs: cs,
            ),
          ),
        ],
      ),
      bottomNavigationBar: AddToCookingAction(recipe: recipe),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ImageWidget(recipe: recipe, cs: cs),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                Text(
                  recipe.title,
                  style: textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),

                RecipeStatsRow(recipe: recipe, colorScheme: cs),
                const SizedBox(height: 16),

                RecipeDifficultyIndicator(
                  difficulty: recipe.difficulty,
                  colorScheme: cs,
                ),

                if (recipe.cuisine.isNotEmpty ||
                    recipe.dietaryInfo.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  RecipeTagsRow(
                    cuisine: recipe.cuisine,
                    dietaryInfo: recipe.dietaryInfo,
                    colorScheme: cs,
                  ),
                ],

                if (recipe.description.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Divider(color: cs.outline.withOpacity(0.1), height: 1),
                  const SizedBox(height: 16),
                  Text(
                    recipe.description,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      height: 1.7,
                      color: cs.onSurface.withOpacity(0.65),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                RecipeSectionHeader(
                  title: l10n.ingredients_title,
                  count: recipe.ingredients.length,
                  colorScheme: cs,
                ),

                const SizedBox(height: 10),

                ...[
                  ...recipe.ingredients
                      .where((i) => i.isAvailable)
                      .map(
                        (ing) =>
                            IngredientCard(ingredient: ing, colorScheme: cs),
                      ),
                  ...recipe.ingredients
                      .where((i) => !i.isAvailable)
                      .map(
                        (ing) =>
                            IngredientCard(ingredient: ing, colorScheme: cs),
                      ),
                ],

                const SizedBox(height: 20),

                if (recipe.missingIngredients.isNotEmpty) ...[
                  MissingIngredientsHeader(
                    colorScheme: cs,
                    count: recipe.missingIngredients.length,
                  ),
                  const SizedBox(height: 10),
                  ...recipe.missingIngredients.map(
                    (m) => MissingIngredientCard(name: m, colorScheme: cs),
                  ),
                  const SizedBox(height: 24),
                ],

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.cooking_instructions,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${recipe.instructions.length} steps",
                        style: TextStyle(
                          color: cs.onPrimaryContainer,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                ...List.generate(
                  recipe.instructions.length,
                  (i) => InstructionStepCard(
                    step: i + 1,
                    text: recipe.instructions[i],
                    colorScheme: cs,
                  ),
                ),

                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final ColorScheme cs;

  const AppBarButton({
    required this.icon,
    required this.onPressed,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: cs.surface.withOpacity(0.92),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: cs.onSurface, size: 20),
      ),
    );
  }
}
