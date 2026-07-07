import 'package:flutter/material.dart';

class ChronosTheme {
  static const Color primaryGold = Color(0xFFC5A059);
  static const Color backgroundBlack = Color(0xFF0A0A0A);
  static const Color surfaceGrey = Color(0xFF1A1A1A);
  static const Color textWhite = Color(0xFFF5F5F5);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryGold,
    scaffoldBackgroundColor: backgroundBlack,
    fontFamily: 'Playfair Display',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: textWhite,
        letterSpacing: -0.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textWhite,
        height: 1.6,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: primaryGold,
      surface: surfaceGrey,
    ),
  );

  static BoxDecoration glassBoxDecoration({double opacity = 0.1}) {
    return BoxDecoration(
      color: Colors.white.withOpacity(opacity),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: 1,
      ),
    );
  }

  static const Curve defaultCurve = Curves.easeInOutCubic;
}
