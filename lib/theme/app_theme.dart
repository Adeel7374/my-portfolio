import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF667eea);
  static const Color deepPurple = Color(0xFF764ba2);
  static const Color accentBlue = Color(0xFF4facfe);
  static const Color successGreen = Color(0xFF00d4aa);
  static const Color warningOrange = Color(0xFFffb347);
  static const Color backgroundNavy = Color(0xFF0f0f23);
  static const Color cardBlueGrey = Color(0xFF1a1a2e);
  static const Color textPrimary = Color(0xFFffffff);
  static const Color textSecondary = Color(0xFFA0A0A0);

  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [primaryBlue, deepPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  static LinearGradient get accentGradient => const LinearGradient(
        colors: [accentBlue, deepPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  static LinearGradient get successGradient => const LinearGradient(
        colors: [successGreen, accentBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  static LinearGradient get warningGradient => const LinearGradient(
        colors: [warningOrange, accentBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static ThemeData buildTheme(Brightness brightness, {TextTheme? textTheme}) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          brightness == Brightness.dark ? backgroundNavy : Colors.white,
      textTheme: textTheme?.apply(
        bodyColor:
            brightness == Brightness.dark ? textPrimary : Colors.black87,
        displayColor:
            brightness == Brightness.dark ? textPrimary : Colors.black87,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: accentBlue),
      chipTheme: ChipThemeData(
        backgroundColor: cardBlueGrey,
        labelStyle: const TextStyle(color: textSecondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:
            brightness == Brightness.dark ? Colors.white10 : Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: brightness == Brightness.dark
                ? Colors.white24
                : Colors.black26,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: brightness == Brightness.dark
                ? Colors.white24
                : Colors.black26,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentBlue, width: 1.5),
        ),
        labelStyle: TextStyle(
          color:
              brightness == Brightness.dark ? Colors.white70 : Colors.black54,
        ),
        hintStyle: TextStyle(
          color:
              brightness == Brightness.dark ? Colors.white60 : Colors.black45,
        ),
      ),
    );
  }
}


