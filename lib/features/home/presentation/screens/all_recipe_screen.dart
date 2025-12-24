import 'package:flutter/material.dart' hide FilterChip;
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/core/utils/category_title_utils.dart';

import '../../../../l10n/app_localizations.dart';
import '../widgets/all_screen_empty_state.dart';
import '../widgets/filter_section_widget.dart';
import '../widgets/recipe_grid.dart';
import '../widgets/search_bar.dart';

class AllRecipesScreen extends StatefulWidget {
  final String category;

  const AllRecipesScreen({super.key, required this.category});

  @override
  State<AllRecipesScreen> createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _selectedSort = 'Recent';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final recipes = CategoryTitleScreenUtils.recipes;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            AppBarSection(
              colorScheme: cs,
              title: CategoryTitleScreenUtils.getCategoryTitle(widget.category),
              recipeCount: recipes.length,
              onBack: () => context.pop(),
            ),

            CategorySearchBar(
              colorScheme: cs,
              controller: _searchController,
              onSearch: (query) {},
            ),

            FilterSection(
              colorScheme: cs,
              selectedFilter: _selectedFilter,
              selectedSort: _selectedSort,
              onFilterChanged: (filter) {
                setState(() => _selectedFilter = filter);
              },
              onSortChanged: (sort) {
                setState(() => _selectedSort = sort);
              },
            ),

            Expanded(
              child: recipes.isEmpty
                  ? EmptyState(colorScheme: cs)
                  : RecipeGrid(colorScheme: cs, recipes: recipes),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarSection extends StatelessWidget {
  final ColorScheme colorScheme;
  final String title;
  final int recipeCount;
  final VoidCallback onBack;

  const AppBarSection({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.recipeCount,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: colorScheme.onSurface,
              size: 20,
            ),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  '$recipeCount ${recipeCount == 1 ? l10n.recipe : l10n.recipes} ${l10n.found}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
