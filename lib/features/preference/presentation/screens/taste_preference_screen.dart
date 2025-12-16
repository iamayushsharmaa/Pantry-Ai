import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/recipe_list_args.dart';
import '../../../../core/constant/preference_constant.dart';
import '../../../../core/router/app_route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/taste_preference_bloc.dart';
import '../models/taste_preference_ui_model.dart';
import '../widgets/image_prev_card.dart';
import '../widgets/page_indicator.dart';
import '../widgets/question_widget.dart';

class TastePreferenceScreen extends StatefulWidget {
  final String imagePath;

  const TastePreferenceScreen({required this.imagePath, super.key});

  @override
  State<TastePreferenceScreen> createState() => _TastePreferenceScreenState();
}

class _TastePreferenceScreenState extends State<TastePreferenceScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage(BuildContext context, int currentPage) {
    context.read<TastePreferenceBloc>().add(NextPreferencePage());
    _controller.animateToPage(
      currentPage + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _previousPage(BuildContext context, int currentPage) {
    context.read<TastePreferenceBloc>().add(PreviousPreferencePage());
    _controller.animateToPage(
      currentPage - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;


    return BlocBuilder<TastePreferenceBloc, TastePreferenceState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: cs.surface,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: cs.surface,
            title: Text(
              l10n.taste_preference_title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onBackground,
              ),
            ),
            leading: state.currentPage > 0
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: cs.onBackground),
                    onPressed: () => _previousPage(context, state.currentPage),
                  )
                : null,
          ),
          body: SafeArea(
            child: Column(
              children: [
                // _AppBarSection(
                //   colorScheme: cs,
                //   showBackButton: state.currentPage > 0,
                //   onBackPressed: () =>
                //       _previousPage(context, state.currentPage),
                // ),
                const SizedBox(height: 18),
                ImagePreviewCard(imagePath: widget.imagePath, colorScheme: cs),
                const SizedBox(height: 20),
                PageIndicator(
                  currentPage: state.currentPage,
                  totalPages: 4,
                  colorScheme: cs,
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      QuestionPage(
                        title: l10n.how_would_you_like_to_taste,
                        options: PreferenceData.tasteOptions,
                        selected: state.taste,
                        onSelected: (val) {
                          context.read<TastePreferenceBloc>().add(
                            SelectTaste(val),
                          );
                        },
                      ),
                      QuestionPage(
                        title: l10n.which_cuisine_do_you_prefer,
                        options: PreferenceData.cuisineOptions,
                        selected: state.cuisine,
                        onSelected: (val) {
                          context.read<TastePreferenceBloc>().add(
                            SelectCuisine(val),
                          );
                        },
                      ),
                      QuestionPage(
                        title: l10n.whats_your_diet_preference,
                        options: PreferenceData.dietOptions,
                        selected: state.diet,
                        onSelected: (val) {
                          context.read<TastePreferenceBloc>().add(
                            SelectDiet(val),
                          );
                        },
                      ),
                      QuestionPage(
                        title: l10n.how_much_time_do_you_have,
                        options: PreferenceData.cookingTimeOptions,
                        selected: state.maxCookingTime,
                        onSelected: (val) {
                          context.read<TastePreferenceBloc>().add(
                            SelectMaxCookingTime(val),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                BottomActionButton(
                  colorScheme: cs,
                  enabled: state.isCurrentStepValid,
                  isLastPage: state.isLastPage,
                  onPressed: () {
                    if (!state.isLastPage) {
                      _nextPage(context, state.currentPage);
                      return;
                    }
                    final prefs = TastePreferencesUi(
                      taste: state.taste,
                      cuisine: state.cuisine,
                      diet: state.diet,
                      maxCookingTime: state.maxCookingTime,
                    );
                    context.pushReplacementNamed(
                      AppRouteNames.recipesList,
                      extra: RecipeListArgs(
                        imagePath: widget.imagePath,
                        preferences: prefs.toEntity(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AppBarSection extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool showBackButton;
  final VoidCallback onBackPressed;

  const _AppBarSection({
    required this.colorScheme,
    required this.showBackButton,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              onPressed: onBackPressed,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: colorScheme.onSurface,
                size: 20,
              ),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            )
          else
            const SizedBox(width: 48),

          Expanded(
            child: Text(
              'Taste Preferences',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
                letterSpacing: -0.3,
              ),
            ),
          ),

          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class BottomActionButton extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool enabled;
  final bool isLastPage;
  final VoidCallback onPressed;

  const BottomActionButton({
    required this.colorScheme,
    required this.enabled,
    required this.isLastPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: RepaintBoundary(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: enabled
                ? LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withOpacity(0.9),
                    ],
                  )
                : null,
            color: enabled ? null : colorScheme.surfaceContainerHighest,
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: enabled ? onPressed : null,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLastPage ? l10n.finish_and_generate : l10n.next,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: enabled
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface.withOpacity(0.4),
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (!isLastPage) ...[
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: enabled
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface.withOpacity(0.4),
                        size: 20,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
