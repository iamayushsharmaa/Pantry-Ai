import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemedScaffold extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool useSafeArea;
  final bool extendBehindStatusBar;
  final SystemUiOverlayStyle? overlayStyle;

  const ThemedScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.useSafeArea = true,
    this.extendBehindStatusBar = false,
    this.overlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final effectiveBackground = backgroundColor ?? cs.surface;

    final effectiveOverlayStyle =
        overlayStyle ??
        SystemUiOverlayStyle(
          statusBarColor: extendBehindStatusBar
              ? Colors.transparent
              : effectiveBackground,
          statusBarIconBrightness: theme.brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          statusBarBrightness: theme.brightness == Brightness.dark
              ? Brightness.dark
              : Brightness.light, // iOS
        );

    Widget content = Scaffold(
      backgroundColor: effectiveBackground,
      extendBodyBehindAppBar: extendBehindStatusBar,
      body: useSafeArea ? SafeArea(child: child) : child,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: effectiveOverlayStyle,
      child: content,
    );
  }
}
