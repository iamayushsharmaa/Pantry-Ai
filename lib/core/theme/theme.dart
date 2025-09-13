import 'package:flutter/material.dart';

final Color kBrandColor = Color(0xFF00A87D);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kBrandColor,
  colorScheme: ColorScheme.light(
    primary: kBrandColor,
    secondary: Colors.black, // secondary accent for text/icons
    onPrimary: Colors.white, // text color on primary buttons
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kBrandColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kBrandColor,
  colorScheme: ColorScheme.dark(
    primary: kBrandColor,
    secondary: Colors.white, // secondary accent for text/icons
    onPrimary: Colors.black, // text color on primary buttons
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kBrandColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);
