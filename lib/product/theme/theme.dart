import 'package:akillisletme/product/theme/app_theme_colors.dart';
import 'package:akillisletme/product/theme/app_theme_variant.dart';
import 'package:flutter/material.dart';

part 'base/color_schemes.dart';
part 'parts/card_theme.dart';
part 'parts/button_theme.dart';
part 'parts/input_theme.dart';
part 'parts/appbar_theme.dart';
part 'parts/chip_theme.dart';
part 'parts/slider_theme.dart';
part 'parts/switch_theme.dart';
part 'base/dark_theme.dart';
part 'base/light_theme.dart';
part 'parts/text_theme.dart';

final class AppTheme {
  AppTheme._();
  static ThemeData darkTheme(AppThemeVariant variant) =>
      _buildDarkTheme(_darkSchemeFor(variant));
  static ThemeData lightTheme(AppThemeVariant variant) =>
      _buildLightTheme(_lightSchemeFor(variant));
}
