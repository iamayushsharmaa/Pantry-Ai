import 'package:flutter/material.dart';
import 'package:pantry_ai/core/common/state_chip.dart';

import '../widgets/quick_recipe_list.dart';
import '../widgets/recent_recipe_list.dart';
import '../widgets/scan_card_widget.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarSection(colorScheme: cs),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ScanCardWidget(),
              ),

              const SizedBox(height: 32),

              SectionHeader(
                colorScheme: cs,
                title: "Recently Generated",
                subtitle: "Your latest recipe discoveries",
                onSeeAll: () {},
              ),

              const SizedBox(height: 16),

              RecentRecipesList(colorScheme: cs),

              const SizedBox(height: 32),

              SectionHeader(
                colorScheme: cs,
                title: "Quick & Easy",
                subtitle: "Recipes under 30 minutes",
                onSeeAll: () {
                  // Navigate to quick recipes
                },
              ),

              const SizedBox(height: 16),

              QuickRecipesList(colorScheme: cs),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const AppBarSection({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pantry AI',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'Cook smart with AI',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          StatChip(
            icon: Icons.local_fire_department_rounded,
            label: "630 cal",
            color: Colors.deepOrange,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}
