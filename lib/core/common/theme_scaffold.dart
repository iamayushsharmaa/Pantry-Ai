import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemedScaffold extends StatelessWidget {
  final Widget child;

  const ThemedScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: cs.surface,
        statusBarIconBrightness: theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: cs.surface,
        body: SafeArea(child: child),
      ),
    );
  }
}
