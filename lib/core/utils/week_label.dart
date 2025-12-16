import 'package:flutter/cupertino.dart';

import '../../features/analytics/domain/entities/range.dart';
import '../../l10n/app_localizations.dart';

String label(AnalyticsRange range, BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  switch (range) {
    case AnalyticsRange.week:
      return l10n.week;
    case AnalyticsRange.month:
      return l10n.month;
    case AnalyticsRange.all:
    default:
      return l10n.all;
  }
}
