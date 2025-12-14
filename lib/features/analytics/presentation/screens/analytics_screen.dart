import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/analytics_bloc.dart';
import '../widgets/empty_state.dart';
import '../widgets/header.dart';
import '../widgets/insight_card.dart';
import '../widgets/kpi_grid.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: cs.surface,
        elevation: 0,
      ),
      body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {
          if (state is AnalyticsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AnalyticsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AnalyticsBloc>().add(RefreshAnalytics());
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  AnalyticsHeader(range: state.range),
                  const SizedBox(height: 16),
                  AnalyticsKpiGrid(analytics: state.analytics),
                  const SizedBox(height: 24),
                  AnalyticsInsightCard(analytics: state.analytics),
                ],
              ),
            );
          }

          return const EmptyAnalyticsState();
        },
      ),
    );
  }
}
