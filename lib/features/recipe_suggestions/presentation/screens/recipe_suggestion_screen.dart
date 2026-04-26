import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/recipe_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/preference_summary_widget.dart';
import '../widgets/recipe_card_widget.dart';
import '../widgets/recipe_error_widget.dart';
import '../widgets/recipe_loading_widget.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cs.surface,
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.status == RecipeStatus.initial) {
            return const SizedBox.shrink();
          }

          if (state.status == RecipeStatus.loading && state.recipes.isEmpty) {
            return const RecipeLoadingWidget();
          }

          if (state.status == RecipeStatus.failure && state.recipes.isEmpty) {
            return const RecipeErrorWidget();
          }

          final recipes = state.recipes;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SuggestionAppBar(colorScheme: cs),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.status == RecipeStatus.failure &&
                          state.error != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: cs.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: cs.onErrorContainer,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  state.error!,
                                  style: TextStyle(
                                    color: cs.onErrorContainer,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (state.imagePath != null && state.preferences != null)
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
                        padding: const EdgeInsets.only(bottom: 12),
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
                                "${recipes.length} ${l10n.recipes}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: cs.onPrimaryContainer,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              l10n.suggested_recipes,
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
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RepaintBoundary(
                        child: RecipeCard(
                          recipe: recipe,
                          colorScheme: cs,
                          onTap: () => context.pushNamed(
                            AppRouteNames.recipeDetail,
                            extra: recipe,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      if (state.canFetchMore)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: cs.primary,
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
                              onTap: state.isLoading
                                  ? null
                                  : () => context.read<RecipeBloc>().add(
                                      FetchMoreRecipesRequested(),
                                    ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
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
                                      l10n.load_more_recipes,
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
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "You've explored all recipe suggestions!",
                            style: TextStyle(
                              color: cs.onSurface.withOpacity(0.4),
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

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
                                l10n.loading_more_recipes,
                                style: TextStyle(
                                  color: cs.onSurface.withOpacity(0.6),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
