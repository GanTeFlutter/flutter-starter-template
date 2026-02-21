import 'package:akillisletme/feature/settings/widget/about_tile.dart';
import 'package:akillisletme/feature/settings/widget/contact_us_tile.dart';
import 'package:akillisletme/feature/settings/widget/language_tile.dart';
import 'package:akillisletme/feature/settings/widget/rate_app_tile.dart';
import 'package:akillisletme/feature/settings/widget/settings_section.dart';
import 'package:akillisletme/feature/settings/widget/theme_tile.dart';
import 'package:akillisletme/product/init/language/locale_keys.g.dart';
import 'package:akillisletme/product/utils/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale; // Dil degisiminde rebuild tetiklemek icin

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings_title.tr())),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.r(16),
          vertical: context.r(8),
        ),
        children: [
          SettingsSection(
            title: LocaleKeys.settings_appearance.tr(),
            children: const [
              ThemeTile(),
              LanguageTile(),
            ],
          ),
          SizedBox(height: context.r(16)),
          SettingsSection(
            title: LocaleKeys.settings_support.tr(),
            children: const [
              ContactUsTile(),
              RateAppTile(),
            ],
          ),
          SizedBox(height: context.r(16)),
          SettingsSection(
            title: LocaleKeys.settings_aboutTitle.tr(),
            children: const [
              AboutTile(),
            ],
          ),
        ],
      ),
    );
  }
}
