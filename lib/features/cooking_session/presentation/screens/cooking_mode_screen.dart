import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_ai/features/cooking_session/presentation/bloc/cooking_session_bloc.dart';

import '../widgets/cooking_progressbar.dart';
import '../widgets/ingredient_checklist.dart';
import '../widgets/step_display.dart';
import '../widgets/timer_widget.dart';
import 'cooking_history_screen.dart';

class CookingModeScreen extends StatelessWidget {
  final String recipeId;

  const CookingModeScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.read<CookingBloc>().add(LoadActiveSessionEvent(recipeId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cooking Mode'),
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CookingHistoryScreen()),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CookingBloc, CookingState>(
          builder: (context, state) {
            if (state is CookingLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CookingError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is! CookingLoaded) return const SizedBox();

            final loaded = state as CookingLoaded;
            final bloc = context.read<CookingBloc>();
            final ingredientsProgress =
                loaded.session.ingredientChecklist.values
                    .where((v) => v)
                    .length /
                loaded.session.ingredientChecklist.length;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CookingProgressBar(
                    currentStep: loaded.session.currentStep,
                    totalSteps: loaded.session.totalSteps,
                    ingredientsProgress: ingredientsProgress,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    loaded.recipe.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Servings: ${loaded.session.servings}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Checklist:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IngredientChecklist(
                    ingredients: loaded.recipe.ingredients,
                    servings: loaded.session.servings,
                    checklist: loaded.session.ingredientChecklist,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Instructions:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // ...loaded.recipe.steps.asMap().entries.map((entry) {
                  //   final index = entry.key;
                  //   final step = entry.value;
                  //   final isCurrent = index == loaded.session.currentStep;
                  //   return Column(
                  //     children: [
                  //       ListTile(
                  //         leading: CircleAvatar(
                  //           child: Text('${index + 1}'),
                  //           backgroundColor: isCurrent
                  //               ? Colors.amber
                  //               : Colors.grey,
                  //         ),
                  //         title: Text('Step ${index + 1}'),
                  //         onTap: () => bloc.add(JumpToStepEvent(index)),
                  //       ),
                  //       if (isCurrent) ...[
                  //         StepDisplay(step: step, isCurrent: true),
                  //         if (step.estimatedMinutes > 0)
                  //           TimerWidget(durationMinutes: step.estimatedMinutes),
                  //       ] else
                  //         const SizedBox(height: 8), // Minimal for non-current
                  //     ],
                  //   );
                  // }),
                ],
              ),
            );
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: 'prev',
              onPressed: () => bloc.add(PreviousStepEvent()),
              child: const Icon(Icons.arrow_back),
            ),
            FloatingActionButton(
              heroTag: 'next',
              onPressed: () {
                if (loaded.session.currentStep ==
                    loaded.session.totalSteps - 1) {
                  _showCompleteDialog(context, bloc);
                } else {
                  bloc.add(NextStepEvent());
                }
              },
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => _showAbandonDialog(context, bloc),
                child: const Text(
                  'Abandon',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              if (loaded.session.status == CookingStatus.completed)
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done!'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCompleteDialog(BuildContext context, CookingBloc bloc) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Finish Cooking?'),
        content: const Text('Mark as complete and log session.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(CompleteCookingEvent());
            },
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  void _showAbandonDialog(BuildContext context, CookingBloc bloc) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Abandon Session?'),
        content: const Text('Progress will be saved for resume.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(AbandonCookingEvent());
              Navigator.pop(context); // Exit screen
            },
            child: const Text('Abandon'),
          ),
        ],
      ),
    );
  }
}
