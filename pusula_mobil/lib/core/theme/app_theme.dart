import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎨 APP THEME
// ═══════════════════════════════════════════════════════════════════════════════════

class PTheme {
  const PTheme._();

  static ThemeData get dark {
    final base = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: PColors.background,
      colorScheme: const ColorScheme.dark(
        surface: PColors.surface,
        primary: PColors.primary,
        secondary: PColors.accent,
      ),
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
    );

    final text = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      displaySmall: GoogleFonts.poppins(
        color: PColors.text,
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: PColors.text,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      titleMedium: GoogleFonts.poppins(
        color: PColors.text,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      bodyLarge: const TextStyle(
        color: PColors.text,
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: const TextStyle(
        color: PColors.textDim,
        fontSize: 14,
        height: 1.45,
      ),
      bodySmall: const TextStyle(color: PColors.textDim, fontSize: 12),
      labelLarge: const TextStyle(
        color: PColors.background,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );

    return base.copyWith(
      textTheme: text,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PColors.surfaceHi,
        labelStyle: const TextStyle(color: PColors.textDim),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: PColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: PColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: PColors.primary, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PColors.primary,
          foregroundColor: PColors.background,
          elevation: 8,
          shadowColor: PColors.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: PColors.surface,
        selectedItemColor: PColors.primary,
        unselectedItemColor: PColors.textDim,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}
