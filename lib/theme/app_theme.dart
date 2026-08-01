import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF102A43);
  static const primaryDark = Color(0xFF081B2F);

  static const gold = Color(0xFFC9A227);
  static const goldSoft = Color(0xFFE8D8A8);

  static const background = Color(0xFFF8F9FB);

  static const card = Colors.white;

  static const text = Color(0xFF1F2937);
  static const textLight = Color(0xFF6B7280);

  // Compatibilidade com arquivos existentes
  static const navy = primary;
  static const navy2 = primaryDark;
  static const sky = Color(0xFFA9C6E8);
  static const skySoft = Color(0xFFE4EEF8);
  static const bronze = gold;
  static const bronzeSoft = goldSoft;
  static const paper = background;
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.gold,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.text,
      titleTextStyle: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    cardTheme: CardTheme(
      elevation: 8,
      color: AppColors.card,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 5,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
