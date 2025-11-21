import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/core/constant/preference_constant.dart';

import '../bloc/taste_preference_bloc.dart';
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
      curve: Curves.ease,
    );
  }

  void _previousPage(BuildContext context, int currentPage) {
    context.read<TastePreferenceBloc>().add(PreviousPreferencePage());
    _controller.animateToPage(
      currentPage - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TastePreferenceBloc, TastePreferenceState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: Text(
              'Taste Preference',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            leading: state.currentPage > 0
                ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => _previousPage(context, state.currentPage),
                  )
                : null,
          ),
          backgroundColor: Colors.black,
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
              const SizedBox(height: 20),

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

              // NAVIGATION BUTTON
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
      title: "What's your diet preference?",
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
    final enabled = state.isCurrentStepValid;
    final isLast = state.isLastPage;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? const Color(0xFF00A87D) : Colors.grey,
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
              final prefs = {
                "taste": state.taste,
                "cuisine": state.cuisine,
                "diet": state.diet,
                "maxCookingTime": state.maxCookingTime,
              };
              context.pushReplacementNamed(
                'recipesList',
                extra: {"imagePath": widget.imagePath, "preferences": prefs},
              );
            },
      child: Text(isLast ? "Finish" : "Next"),
    );
  }
}
