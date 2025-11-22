import 'package:flutter/material.dart';

import '../widgets/scan_card_widget.dart';

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

      appBar: AppBar(
        backgroundColor: cs.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Pantry AI',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: cs.onBackground,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScanCardWidget(),
            const SizedBox(height: 24),
            Text(
              "Your Saved Recipes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: cs.onBackground,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade100
                    : Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 40,
                    color: cs.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "No saved recipes yet",
                    style: TextStyle(
                      fontSize: 15,
                      color: cs.onSurface.withOpacity(0.75),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
