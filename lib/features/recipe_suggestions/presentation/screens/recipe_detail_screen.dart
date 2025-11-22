import 'package:flutter/material.dart';

import '../../domain/enities/recipe_entity.dart';
import '../widgets/difficulty_indicator.dart';
import '../widgets/glass_icon_button.dart';
import '../widgets/ingredient_card.dart';
import '../widgets/instruction_step_card.dart';
import '../widgets/missing_ingredient_card.dart';
import '../widgets/missing_ingredient_header.dart';
import '../widgets/recipe_hero_image.dart';
import '../widgets/recipe_section_handler.dart';
import '../widgets/recipe_state_row.dart';
import '../widgets/recipe_tag_row.dart';
import '../widgets/start_cooking_button.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, cs),

          SliverToBoxAdapter(
            child: RepaintBoundary(child: _buildHeaderSection(cs, textTheme)),
          ),

          if (recipe.description != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Text(
                  recipe.description!,
                  style: TextStyle(
                    color: cs.onBackground.withOpacity(0.75),
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
            ),

          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: RecipeSectionHeader(
                title: "Ingredients",
                count: recipe.ingredients.length,
                colorScheme: cs,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final ing = recipe.ingredients[index];
                  return IngredientCard(ingredient: ing, colorScheme: cs);
                },
                childCount: recipe.ingredients.length,
                addRepaintBoundaries: true, // Performance boost
              ),
            ),
          ),

          if (recipe.missingIngredients.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: MissingIngredientsHeader(colorScheme: cs),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return MissingIngredientCard(
                      name: recipe.missingIngredients[index],
                      colorScheme: cs,
                    );
                  },
                  childCount: recipe.missingIngredients.length,
                  addRepaintBoundaries: true,
                ),
              ),
            ),
          ],

          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                child: Text(
                  "Cooking Instructions",
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: cs.onBackground,
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return InstructionStepCard(
                    step: index + 1,
                    text: recipe.instructions[index],
                    colorScheme: cs,
                  );
                },
                childCount: recipe.instructions.length,
                addRepaintBoundaries: true,
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: RepaintBoundary(
        child: StartCookingButton(colorScheme: cs),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ColorScheme cs) {
    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      backgroundColor: cs.surface,
      elevation: 0,
      leading: GlassIconButton(
        icon: Icons.arrow_back,
        onPressed: () => Navigator.pop(context),
      ),
      actions: const [
        GlassIconButton(icon: Icons.favorite_border),
        GlassIconButton(icon: Icons.share),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: RepaintBoundary(
          child: RecipeHeroImage(imageUrl: recipe.imageUrl, tag: recipe.title),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(ColorScheme cs, TextTheme textTheme) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        decoration: BoxDecoration(
          color: cs.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.title,
                style: textTheme.headlineMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: cs.onBackground,
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
            ],
          ),
        ),
      ),
    );
  }
}
