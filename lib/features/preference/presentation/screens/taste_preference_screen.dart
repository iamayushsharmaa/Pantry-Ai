import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/recipe_list_args.dart';
import '../../../../core/constant/preference_constant.dart';
import '../bloc/taste_preference_bloc.dart';
import '../models/taste_preference_ui_model.dart';
import '../widgets/question_widget.dart';

class TastePreferenceScreen extends StatefulWidget {
  final String imagePath;

  const TastePreferenceScreen({required this.imagePath, Key? key})
    : super(key: key);

  @override
  State<TastePreferenceScreen> createState() => _TastePreferenceScreenState();
}

class _TastePreferenceScreenState extends State<TastePreferenceScreen> {
  final PageController _controller = PageController();

  void _nextPage(BuildContext context, int currentPage) {
    context.read<TastePreferenceBloc>().add(NextPreferencePage());
    _controller.animateToPage(
      currentPage + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _previousPage(BuildContext context, int currentPage) {
    context.read<TastePreferenceBloc>().add(PreviousPreferencePage());
    _controller.animateToPage(
      currentPage - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TastePreferenceBloc, TastePreferenceState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: cs.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: cs.background,
            title: Text(
              'Taste Preferences',
              style: textTheme.titleLarge?.copyWith(
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

          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(widget.imagePath),
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  final isActive = i == state.currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 26 : 10,
                    decoration: BoxDecoration(
                      color: isActive ? cs.primary : cs.outlineVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 22),

              Expanded(
                child: PageView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildTastePage(context, state),
                    _buildCuisinePage(context, state),
                    _buildDietPage(context, state),
                    _buildTimePage(context, state),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildBottomButton(context, state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTastePage(BuildContext context, TastePreferenceState state) {
    return QuestionWidget(
      title: "How would you like the taste?",
      options: PreferenceData.tasteOptions,
      selected: state.taste,
      onSelected: (val) {
        context.read<TastePreferenceBloc>().add(SelectTaste(val));
      },
    );
  }

  Widget _buildCuisinePage(BuildContext context, TastePreferenceState state) {
    return QuestionWidget(
      title: "Which cuisine do you prefer?",
      options: PreferenceData.cuisineOptions,
      selected: state.cuisine,
      onSelected: (val) {
        context.read<TastePreferenceBloc>().add(SelectCuisine(val));
      },
    );
  }

  Widget _buildDietPage(BuildContext context, TastePreferenceState state) {
    return QuestionWidget(
      title: "What’s your diet preference?",
      options: PreferenceData.dietOptions,
      selected: state.diet,
      onSelected: (val) {
        context.read<TastePreferenceBloc>().add(SelectDiet(val));
      },
    );
  }

  Widget _buildTimePage(BuildContext context, TastePreferenceState state) {
    return QuestionWidget(
      title: "How much time do you have?",
      options: PreferenceData.cookingTimeOptions,
      selected: state.maxCookingTime,
      onSelected: (val) {
        context.read<TastePreferenceBloc>().add(SelectMaxCookingTime(val));
      },
    );
  }

  Widget _buildBottomButton(BuildContext context, TastePreferenceState state) {
    final cs = Theme.of(context).colorScheme;

    final enabled = state.isCurrentStepValid;
    final isLast = state.isLastPage;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? cs.primary : cs.surfaceVariant,
        foregroundColor: enabled ? cs.onPrimary : cs.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: !enabled
          ? null
          : () {
              if (!isLast) {
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
                'recipesList',
                extra: RecipeListArgs(
                  imagePath: widget.imagePath,
                  preferences: prefs.toEntity(),
                ),
              );
            },
      child: Text(isLast ? "Finish" : "Next"),
    );
  }
}
