// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const double appBarHeight = 44.0;

  // Base brand colors (muted blues/greys with vibrant accents)
  static const Color _primary = Color(0xFF3A7BD5); // blue accent
  static const Color _secondary = Color(0xFF00D2FF); // cyan accent
  static const Color _surfaceTint = Color(0xFF9BB1C8);
  static const Color _bgDark = Color(0xFF0D1220);
  static const Color _bgLight = Color(0xFFF2F5F9);

  static ThemeData light() {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
      primary: _primary,
      secondary: _secondary,
      surfaceTint: _surfaceTint,
      background: _bgLight,
    );
    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _bgLight, // <<<< CHANGED
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.6),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.6),
        border: _outlineBorder(),
        enabledBorder: _outlineBorder(),
        focusedBorder: _outlineBorder(_primary),
        hintStyle: TextStyle(color: Colors.grey.shade600),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.6),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white.withOpacity(0.6),
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.grey.shade700,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.dark);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.dark,
      primary: _primary,
      secondary: _secondary,
      surfaceTint: _surfaceTint,
      background: _bgDark,
    );
    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _bgDark, // <<<< CHANGED
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.06),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        border: _outlineBorder(null, 0.18),
        enabledBorder: _outlineBorder(null, 0.18),
        focusedBorder: _outlineBorder(_primary, 0.6),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.66)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.secondary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.06),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white.withOpacity(0.06),
        selectedItemColor: colorScheme.secondary,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _secondary,
      ),
    );
  }

  // Positional args: [color?, opacity=0.24]
  static OutlineInputBorder _outlineBorder([Color? color, double opacity = 0.24]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: (color ?? Colors.white).withOpacity(opacity), width: 1.2),
    );
  }
}