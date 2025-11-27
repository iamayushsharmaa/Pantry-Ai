import 'package:flutter/material.dart';
import 'package:pantry_ai/core/utils/show_snackbar.dart';
import 'package:pantry_ai/shared/widgets/favorite_button.dart';

import '../../../recipe_suggestions/domain/enities/recipe_entity.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/action_buttons.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/difficulty_indicator.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/ingredient_card.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/instruction_step_card.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/missing_ingredient_card.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/missing_ingredient_header.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/recipe_section_header.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/recipe_state_row.dart';
import '../../../recipe_suggestions/presentation/widgets/widgets/recipe_tag_row.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isFavorite = false;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;

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
          FavoriteButton(recipe: widget.recipe),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.surface.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved ? cs.primary : cs.onSurface,
                size: 22,
              ),
            ),
            onPressed: () {
              setState(() => isSaved = !isSaved);
              showSnackBar(
                context,
                isSaved ? 'Recipe saved 📌' : 'Recipe unsaved',
                cs,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: ActionButtons(
        colorScheme: cs,
        onStartCooking: () {
          showSnackBar(context, 'Starting cooking mode! 👨‍🍳', cs);
        },
        onMarkAsCooked: () {
          showSnackBar(context, 'Marked as cooked! ✅', cs);
        },
      ),
      body: CustomScrollView(
        slivers: [
          // Hero Image
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
                      widget.recipe.imageUrl,
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
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) =>
                          Container(
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
                // Gradient Overlay
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
                  widget.recipe.title,
                  style: textTheme.headlineMedium?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

                RecipeStatsRow(recipe: widget.recipe, colorScheme: cs),
                const SizedBox(height: 16),

                RecipeDifficultyIndicator(
                  difficulty: widget.recipe.difficulty,
                  colorScheme: cs,
                ),

                if (widget.recipe.cuisine != null ||
                    widget.recipe.dietaryInfo != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: RecipeTagsRow(
                      cuisine: widget.recipe.cuisine,
                      dietaryInfo: widget.recipe.dietaryInfo,
                      colorScheme: cs,
                    ),
                  ),

                const SizedBox(height: 20),

                if (widget.recipe.description != null)
                  Text(
                    widget.recipe.description!,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      height: 1.6,
                      color: cs.onSurface.withOpacity(0.8),
                    ),
                  ),

                const SizedBox(height: 24),

                RecipeSectionHeader(
                  title: "Ingredients",
                  count: widget.recipe.ingredients.length,
                  colorScheme: cs,
                ),
                const SizedBox(height: 12),

                ...widget.recipe.ingredients.map(
                      (ing) => IngredientCard(ingredient: ing, colorScheme: cs),
                ),

                const SizedBox(height: 20),

                if (widget.recipe.missingIngredients.isNotEmpty) ...[
                  MissingIngredientsHeader(colorScheme: cs),
                  const SizedBox(height: 8),
                  ...widget.recipe.missingIngredients.map(
                        (m) => MissingIngredientCard(name: m, colorScheme: cs),
                  ),
                  const SizedBox(height: 20),
                ],

                Text(
                  "Cooking Instructions",
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 12),

                ...List.generate(widget.recipe.instructions.length, (i) {
                  return InstructionStepCard(
                    step: i + 1,
                    text: widget.recipe.instructions[i],
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
  }
}
