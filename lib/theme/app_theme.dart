import 'package:flutter/material.dart';

class AppColors {
  static const navy = Color(0xFF16273F);
  static const navy2 = Color(0xFF1F3654);
  static const sky = Color(0xFFA9C6E8);
  static const skySoft = Color(0xFFE4EEF8);
  static const bronze = Color(0xFF9C7A5C);
  static const bronzeSoft = Color(0xFFEAE0D3);
  static const paper = Color(0xFFF6F5F2);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.paper,
    fontFamily: 'Roboto',
  );
}
