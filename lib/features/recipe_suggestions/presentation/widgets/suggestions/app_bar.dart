import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuggestionAppBar extends StatelessWidget {
  final ColorScheme colorScheme;

  const SuggestionAppBar({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(
          Icons.arrow_back_rounded,
          color: colorScheme.onSurface,
          size: 20,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 16),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Recommended Dishes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "Smart recipes based on your scan",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: colorScheme.onSurface.withOpacity(0.6),
                letterSpacing: 0,
              ),
            ),
          ],
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.primaryContainer.withOpacity(0.3),
                colorScheme.surface,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
