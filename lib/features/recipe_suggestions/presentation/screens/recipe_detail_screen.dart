import 'package:flutter/material.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/widgets/details/header.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/widgets/details/missing_ingredient_header.dart';

import '../../domain/enities/recipe_entity.dart';
import '../widgets/details/glass_icon_button.dart';
import '../widgets/details/ingredient_card.dart';
import '../widgets/details/instruction_step_card.dart';
import '../widgets/details/missing_ingredient_card.dart';
import '../widgets/details/recipe_section_header.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        backgroundColor: cs.background,
        elevation: 0,
        leading: GlassIconButton(icon: Icons.arrow_back),
      ),
      // bottomNavigationBar: StartCookingButton(colorScheme: cs),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),

            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: FadeInImage(
                  placeholder: const AssetImage(
                    'assets/images/placeholder.jpg',
                  ),
                  image: NetworkImage(recipe.imageUrl),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 250),
                  fadeInCurve: Curves.easeOut,
                  imageErrorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, size: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),

            Header(recipe: recipe, cs: cs, textTheme: textTheme),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Text(
                recipe.description!,
                style: textTheme.titleMedium!.copyWith(
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 15),

            RecipeSectionHeader(
              title: "Ingredients",
              count: recipe.ingredients.length,
              colorScheme: cs,
            ),

            const SizedBox(height: 12),

            ...recipe.ingredients.map(
              (ing) => IngredientCard(ingredient: ing, colorScheme: cs),
            ),

            const SizedBox(height: 15),

            if (recipe.missingIngredients.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MissingIngredientsHeader(colorScheme: cs),
                  const SizedBox(height: 7),
                  ...recipe.missingIngredients.map(
                    (m) => MissingIngredientCard(name: m, colorScheme: cs),
                  ),
                ],
              ),

            const SizedBox(height: 15),

            Text(
              "Cooking Instructions",
              style: textTheme.titleLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: cs.onBackground,
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
          ],
        ),
      ),
    );
  }
}
