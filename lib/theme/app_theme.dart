import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundBase,
    colorScheme: ColorScheme.light(
      primary: AppColors.emerald,
      secondary: AppColors.blue,
      surface: AppColors.glassPanelFill,
      error: AppColors.amber,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundBase,
      foregroundColor: AppColors.textHigh,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.textHigh,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: AppColors.textMedium),
      bodySmall: TextStyle(color: AppColors.textLow),
    ),
    fontFamily: 'Arial',
  );
}
