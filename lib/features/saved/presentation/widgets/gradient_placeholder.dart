import 'package:flutter/material.dart';

class GradientPlaceholder extends StatelessWidget {
  final Color color;

  const GradientPlaceholder({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.7)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant_menu_rounded,
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
      ),
    );
  }
}
