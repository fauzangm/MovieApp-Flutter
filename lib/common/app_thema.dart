import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.light.scaffoldBackground,
    cardColor: AppColors.light.cardBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.light.accent,
      secondary: AppColors.light.indicatorActive,
      surface: AppColors.light.surface,
      onPrimary: AppColors.light.textPrimary,
      onSurface: AppColors.light.textPrimary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.dark.scaffoldBackground,
    cardColor: AppColors.dark.cardBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.dark.accent,
      secondary: AppColors.dark.indicatorActive,
      surface: AppColors.dark.surface,
      onPrimary: AppColors.dark.textPrimary,
      onSurface: AppColors.dark.textPrimary,
    ),
  );
}