import 'package:akillisletme/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isTurkish = context.locale.languageCode == 'tr';

    return ListTile(
      leading: Icon(Icons.language, color: cs.onSurfaceVariant),
      title: Text(LocaleKeys.settings_language.tr()),
      trailing: Text(
        isTurkish ? 'Türkçe' : 'English',
        style: TextStyle(color: cs.onSurfaceVariant),
      ),
      onTap: () {
        if (isTurkish) {
          context.setLocale(const Locale('en', 'US'));
        } else {
          context.setLocale(const Locale('tr', 'TR'));
        }
      },
    );
  }
}
