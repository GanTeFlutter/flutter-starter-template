import 'package:flutter/material.dart';

/// Çeviriye tabi olmayan sabit stringler.
/// Çevirili stringler için LocaleKeys + .tr() kullan.
@immutable
final class AppString {
  const AppString._();

  // ── Store URL'leri (çeviriye tabi değil) ───────────────────
  static const String appStoreUrl = '';
  static const String playStoreUrl = '';
}
