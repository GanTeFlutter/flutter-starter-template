import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
//  Firebase kurulduktan sonra yorum satırlarını kaldır
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:qrcode_akillisletme/product/service/services/remote_config_service.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

/// Cubit responsible for splash screen logic
/// Handles version check from Firebase Remote Config
class SplashCubit extends Cubit<SplashState> {
  //  Firebase kurulduktan sonra constructor'ı eski haline getir
  SplashCubit() : super(const SplashState.initial());
  // SplashCubit({required RemoteConfigService remoteConfigService})
  //   : _remoteConfigService = remoteConfigService,
  //     super(const SplashState.initial());

  // final RemoteConfigService _remoteConfigService;

  /// Main entry point - performs version check
  Future<void> checkApp() async {
    emit(const SplashState.checking());

    //  Firebase kurulduktan sonra aşağıdaki version check kodunu aktif et
    // try {
    //   final packageInfo = await PackageInfo.fromPlatform();
    //   final currentVersion = packageInfo.version;
    //   final minVersion = _remoteConfigService.minVersion;
    //
    //   if (kDebugMode) {
    //     print('📱 Current Version: $currentVersion');
    //     print('🔥 Min Version from Firebase: $minVersion');
    //   }
    //
    //   final needsUpdate = _isVersionLessThan(currentVersion, minVersion);
    //
    //   if (kDebugMode) {
    //     print('🔄 Needs Update: $needsUpdate');
    //   }
    //
    //   if (needsUpdate) {
    //     emit(
    //       SplashState.updateRequired(
    //         currentVersion: currentVersion,
    //         minimumVersion: minVersion,
    //       ),
    //     );
    //     return;
    //   }
    //
    //   emit(const SplashState.success());
    // } on Exception catch (e) {
    //   if (kDebugMode) {
    //     print('❌ Error during checkApp: $e');
    //   }
    //   emit(SplashState.error(message: 'Bir hata oluştu: $e'));
    // }

    // Firebase olmadan direkt success
    emit(const SplashState.success());
  }

  /// Retry the app check process
  Future<void> retry() async {
    await checkApp();
  }

  //  Firebase kurulduktan sonra bu metodu aktif et
  // bool _isVersionLessThan(String currentVersion, String minVersion) {
  //   final current = currentVersion.split('.').map(int.tryParse).toList();
  //   final min = minVersion.split('.').map(int.tryParse).toList();
  //
  //   for (var i = 0; i < min.length; i++) {
  //     final currentPart = i < current.length ? (current[i] ?? 0) : 0;
  //     final minPart = min[i] ?? 0;
  //
  //     if (currentPart < minPart) return true;
  //     if (currentPart > minPart) return false;
  //   }
  //   return false;
  // }
}
