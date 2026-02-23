import 'package:akillisletme/product/theme/app_theme_variant.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeState {
  const ThemeState({
    this.variant = AppThemeVariant.purple,
    this.themeMode = ThemeMode.system,
  });

  final AppThemeVariant variant;
  final ThemeMode themeMode;

  ThemeState copyWith({
    AppThemeVariant? variant,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      variant: variant ?? this.variant,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeState &&
          runtimeType == other.runtimeType &&
          variant == other.variant &&
          themeMode == other.themeMode;

  @override
  int get hashCode => Object.hash(variant, themeMode);
}
