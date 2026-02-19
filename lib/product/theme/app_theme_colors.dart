import 'package:flutter/material.dart';

/// Semantik renkler icin ThemeExtension.
/// Skor/toggle renkleri anlamsal (gold=perfect, red=bad, green=active)
/// oldugu icin tema variant'iyla degismez ama dark/light'a uyum saglar.
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.scoreGold,
    required this.scoreRed,
    required this.scoreGreen,
    required this.scoreBlue,
    required this.scorePink,
    required this.toggleActive,
    required this.toggleInactive,
  });
  final Color scoreGold;
  final Color scoreRed;
  final Color scoreGreen;
  final Color scoreBlue;
  final Color scorePink;
  final Color toggleActive;
  final Color toggleInactive;

  static const appColors = AppThemeColors(
    scoreGold: Color(0xFFFFD700),
    scoreRed: Color(0xFFFF4757),
    scoreGreen: Color(0xFF2ED573),
    scoreBlue: Color(0xFF1E90FF),
    scorePink: Color(0xFFFF6B81),
    toggleActive: Color(0xFF2ED573),
    toggleInactive: Color(0xFFEF5350),
  );

  @override
  AppThemeColors copyWith({
    Color? scoreGold,
    Color? scoreRed,
    Color? scoreGreen,
    Color? scoreBlue,
    Color? scorePink,
    Color? toggleActive,
    Color? toggleInactive,
  }) => AppThemeColors(
    scoreGold: scoreGold ?? this.scoreGold,
    scoreRed: scoreRed ?? this.scoreRed,
    scoreGreen: scoreGreen ?? this.scoreGreen,
    scoreBlue: scoreBlue ?? this.scoreBlue,
    scorePink: scorePink ?? this.scorePink,
    toggleActive: toggleActive ?? this.toggleActive,
    toggleInactive: toggleInactive ?? this.toggleInactive,
  );

  @override
  AppThemeColors lerp(covariant AppThemeColors? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      scoreGold: Color.lerp(scoreGold, other.scoreGold, t)!,
      scoreRed: Color.lerp(scoreRed, other.scoreRed, t)!,
      scoreGreen: Color.lerp(scoreGreen, other.scoreGreen, t)!,
      scoreBlue: Color.lerp(scoreBlue, other.scoreBlue, t)!,
      scorePink: Color.lerp(scorePink, other.scorePink, t)!,
      toggleActive: Color.lerp(toggleActive, other.toggleActive, t)!,
      toggleInactive: Color.lerp(toggleInactive, other.toggleInactive, t)!,
    );
  }
}
