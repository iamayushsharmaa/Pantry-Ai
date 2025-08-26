import 'package:flutter/material.dart';

final Color brandColor = Color(0xFF00BCD4); // Teal Blue

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: brandColor,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: brandColor,
    secondary: brandColor,
    background: Colors.white,
    surface: Color(0xFFF5F5F5), // light grey
    onBackground: Colors.black,
    onSurface: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Color(0xFF4A4A4A)), // dark grey
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: brandColor,
  scaffoldBackgroundColor: Color(0xFF121212), // almost black
  colorScheme: ColorScheme.dark(
    primary: brandColor,
    secondary: brandColor,
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E), // dark grey
    onBackground: Colors.white,
    onSurface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF121212),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Color(0xFFB3B3B3)), // grey
  ),
);
