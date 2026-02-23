import 'package:akillisletme/product/cache/shared_operation/shared_keys.dart';
import 'package:akillisletme/product/service/service_locator.dart';
import 'package:akillisletme/product/theme/app_theme_variant.dart';
import 'package:akillisletme/product/theme/state/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _load();
  }

  void _load() {
    final variantKey =
        locator.sharedCache.getValue<String>(SharedKeys.themeVariant);
    final themeModeKey =
        locator.sharedCache.getValue<String>(SharedKeys.theme);

    emit(
      ThemeState(
        variant: variantKey != null
            ? AppThemeVariant.fromKey(variantKey)
            : state.variant,
        themeMode: themeModeKey != null
            ? _themeModeFromKey(themeModeKey)
            : state.themeMode,
      ),
    );
  }

  Future<void> setVariant(AppThemeVariant variant) async {
    await locator.sharedCache
        .setValue<String>(SharedKeys.themeVariant, variant.key);
    emit(state.copyWith(variant: variant));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await locator.sharedCache.setValue<String>(SharedKeys.theme, mode.name);
    emit(state.copyWith(themeMode: mode));
  }

  static ThemeMode _themeModeFromKey(String key) {
    return ThemeMode.values.firstWhere(
      (m) => m.name == key,
      orElse: () => ThemeMode.system,
    );
  }
}
