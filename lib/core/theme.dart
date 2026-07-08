import 'package:flutter/material.dart';

class ChronosTheme {
  static const Color gold = Color(0xFFD4AF37);
  static const Color darkBlack = Color(0xFF0A0A0A);
  static const Color accentGray = Color(0xFF2C2C2C);
  static const Color offWhite = Color(0xFFF5F5F5);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: gold,
        brightness: Brightness.dark,
        primary: gold,
        onPrimary: darkBlack,
        surface: darkBlack,
        onSurface: offWhite,
      ),
      scaffoldBackgroundColor: darkBlack,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: offWhite,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: gold,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          color: offWhite,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: gold,
        ),
      ),
    );
  }
}
