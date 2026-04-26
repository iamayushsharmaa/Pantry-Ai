

import 'package:flutter/material.dart';

Color recipeColorFromTitle(String title) {
  const colors = [
    Color(0xFF00A87D), // brand green
    Color(0xFF0891B2), // cyan
    Color(0xFF7C3AED), // violet
    Color(0xFFEA580C), // orange
    Color(0xFF0D9488), // teal
    Color(0xFFDB2777), // pink
    Color(0xFF65A30D), // lime
    Color(0xFF9333EA), // purple
  ];
  return colors[title.hashCode.abs() % colors.length];
}