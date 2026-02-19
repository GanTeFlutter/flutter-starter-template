import 'package:flutter/material.dart';

enum AppLocale {
  tr(Locale('tr', 'TR')),
  en(Locale('en', 'US'));

  const AppLocale(this.locale);
  final Locale locale;
}

@immutable
class CoreLocalize {
  const CoreLocalize();

  static const initialPath = 'assets/translations';
  static final startLocale = AppLocale.tr.locale;
  static final List<Locale> supportedItems =
      AppLocale.values.map((e) => e.locale).toList();
}
