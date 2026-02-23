import 'package:akillisletme/product/init/language/locale_keys.g.dart';
import 'package:akillisletme/product/theme/state/theme_cubit.dart';
import 'package:akillisletme/product/theme/widget/theme_selection_dialog.dart';
import 'package:akillisletme/product/utils/theme_decorations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Uygulama tema secim tile'i.
class ThemeSettingTile extends StatelessWidget {
  const ThemeSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final variant = context.watch<ThemeCubit>().state.variant;
    return GestureDetector(
      onTap: () => ThemeSelectionDialog.show(context),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: context.settingContainerDecoration,
        child: Row(
          children: [
            Icon(
              Icons.palette_rounded,
              color: variant.previewColor,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.settings_appTheme.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    variant.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: cs.onSurface.withValues(alpha: 0.6),
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: variant.previewColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
