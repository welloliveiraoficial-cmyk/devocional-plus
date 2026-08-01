import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Paleta principal
  static const primary = Color(0xFF16273F);
  static const primaryDark = Color(0xFF0D1B2E);

  static const gold = Color(0xFFC9A227);
  static const goldSoft = Color(0xFFE8D8A8);
  static const goldBright = Color(0xFFE3C158);

  static const parchment = Color(0xFFF7F1E3);
  static const background = Color(0xFFF7F5F1);
  static const card = Colors.white;

  static const ink = Color(0xFF241E16);
  static const inkLight = Color(0xFF6B6156);

  // Compatibilidade com telas já existentes
  static const navy = primary;
  static const navy2 = primaryDark;
  static const sky = Color(0xFFA9C6E8);
  static const skySoft = Color(0xFFE4EEF8);
  static const bronze = gold;
  static const bronzeSoft = goldSoft;
  static const paper = background;
  static const text = ink;
  static const textLight = inkLight;
}

ThemeData buildAppTheme() {
  final baseText = GoogleFonts.workSansTextTheme();
  final display = GoogleFonts.playfairDisplayTextTheme();

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.gold,
      brightness: Brightness.light,
    ),

    textTheme: baseText.copyWith(
      displayLarge: display.displayLarge?.copyWith(color: AppColors.ink),
      displayMedium: display.displayMedium?.copyWith(color: AppColors.ink),
      headlineLarge: display.headlineLarge?.copyWith(color: AppColors.ink, fontWeight: FontWeight.w600),
      headlineMedium: display.headlineMedium?.copyWith(color: AppColors.ink, fontWeight: FontWeight.w600),
      headlineSmall: display.headlineSmall?.copyWith(color: AppColors.ink, fontWeight: FontWeight.w600),
      titleLarge: display.titleLarge?.copyWith(color: AppColors.ink, fontWeight: FontWeight.w600),
      bodyLarge: baseText.bodyLarge?.copyWith(color: AppColors.ink),
      bodyMedium: baseText.bodyMedium?.copyWith(color: AppColors.ink),
      bodySmall: baseText.bodySmall?.copyWith(color: AppColors.inkLight),
    ),

    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.ink,
      titleTextStyle: GoogleFonts.playfairDisplay(
        color: AppColors.ink,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),

    cardTheme: CardTheme(
      elevation: 6,
      color: AppColors.card,
      shadowColor: AppColors.primary.withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 3,
        minimumSize: const Size(double.infinity, 54),
        textStyle: GoogleFonts.workSans(fontWeight: FontWeight.w600, fontSize: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
