import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';

extension ThemeExtension on BuildContext {
  AppColors get colors {
    return Theme.of(this).brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
  }
}