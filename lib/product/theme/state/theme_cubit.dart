import 'package:akillisletme/product/cache/shared_operation/shared_keys.dart';
import 'package:akillisletme/product/service/service_locator.dart';
import 'package:akillisletme/product/theme/app_theme_variant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<AppThemeVariant> {
  ThemeCubit() : super(AppThemeVariant.purple) {
    _load();
  }

  void _load() {
    final key = locator.sharedCache.getValue<String>(SharedKeys.themeVariant);
    if (key != null) {
      emit(AppThemeVariant.fromKey(key));
    }
  }

  Future<void> setVariant(AppThemeVariant variant) async {
    await locator.sharedCache
        .setValue<String>(SharedKeys.themeVariant, variant.key);
    emit(variant);
  }
}
