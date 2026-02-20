import 'package:flutter/material.dart';

class AppColors {
  final Color gradientStart;
  final Color gradientEnd;

  final Color textPrimary;
  final Color textSecondary;

  final Color indicatorActive;
  final Color indicatorInactive;

  final Color scaffoldBackground;
  final Color surface;
  final Color cardBackground;
  final Color accent;
  final Color bookmarkActive;

  const AppColors({
    required this.gradientStart,
    required this.gradientEnd,
    required this.textPrimary,
    required this.textSecondary,
    required this.indicatorActive,
    required this.indicatorInactive,
    required this.scaffoldBackground,
    required this.surface,
    required this.cardBackground,
    required this.accent,
    required this.bookmarkActive,
  });

  // 🌚 DARK VERSION (warna asli kamu)
  static const dark = AppColors(
    gradientStart: Color(0xFF6B21A8),
    gradientEnd: Color(0xFF1E3A8A),

    textPrimary: Colors.white,
    textSecondary: Colors.white70,

    indicatorActive: Color(0xFF4DA6FF),
    indicatorInactive: Color(0xFF1E3A8A),

    scaffoldBackground: Color(0xFF081025),
    surface: Color(0xFF0E1A26),
    cardBackground: Color(0xFF0F1720),
    accent: Color(0xFF1E90FF),
    bookmarkActive: Color(0xFFFBC02D),
  );

  // 🌞 LIGHT VERSION (adaptasi branding kamu)
  static const light = AppColors(
    gradientStart: Color(0xFF8B5CF6),
    gradientEnd: Color(0xFF3B82F6),

    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),

    indicatorActive: Color(0xFF1E90FF),
    indicatorInactive: Color(0xFFCBD5E1),

    scaffoldBackground: Color(0xFFF4F7FB),
    surface: Colors.white,
    cardBackground: Color(0xFFFFFFFF),
    accent: Color(0xFF1E90FF),
    bookmarkActive: Color(0xFFFBC02D),
  );
}
