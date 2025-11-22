import 'dart:ui';

import 'package:flutter/material.dart';

class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const GlassIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
