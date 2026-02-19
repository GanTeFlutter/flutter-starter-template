import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

/// Service wrapper for Firebase Remote Config
/// Handles app version checking
final class RemoteConfigService {
  RemoteConfigService._();
  static final RemoteConfigService instance = RemoteConfigService._();

  late final FirebaseRemoteConfig _remoteConfig;

  static const String _versionKey = 'version';

  Future<void> init() async {
    _remoteConfig = FirebaseRemoteConfig.instance;

    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: kDebugMode
            ? Duration.zero
            : const Duration(hours: 1),
      ),
    );

    await _remoteConfig.setDefaults(<String, dynamic>{_versionKey: '1.0.0'});

    try {
      await _remoteConfig.fetchAndActivate().timeout(
        const Duration(seconds: 4),
        onTimeout: () => false,
      );
    } on Exception catch (_) {
      // Continue with default values if fetch fails
    }
  }

  String get minVersion => _remoteConfig.getString(_versionKey);

  Future<void> refresh() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } on Exception catch (_) {
      // Silent fail — uses cached values
    }
  }
}
