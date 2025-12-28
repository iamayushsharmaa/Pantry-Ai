import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_ai/core/common/theme_scaffold.dart';

import '../../../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return ThemedScaffold(
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(title: Text(l10n.analytics)),
        body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            if (state is AnalyticsLoading) {
              return Center(
                child: CircularProgressIndicator(color: cs.primary),
              );
            }

            if (state is AnalyticsLoaded) {
              return RefreshIndicator(
                color: cs.primary,
                onRefresh: () async {
                  context.read<AnalyticsBloc>().add(RefreshAnalytics());
                },
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    AnalyticsHeader(range: state.range),
                    const SizedBox(height: 20),
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
      ),
    );
  }
}
