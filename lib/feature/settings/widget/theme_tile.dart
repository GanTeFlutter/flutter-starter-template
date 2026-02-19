import 'package:akillisletme/product/init/language/locale_keys.g.dart';
import 'package:akillisletme/product/theme/state/theme_cubit.dart';
import 'package:akillisletme/product/theme/widget/theme_selection_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final variant = context.watch<ThemeCubit>().state;

    return ListTile(
      leading: Icon(Icons.palette_rounded, color: cs.onSurfaceVariant),
      title: Text(LocaleKeys.settings_theme.tr()),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: variant.previewColor,
          shape: BoxShape.circle,
        ),
      ),
      onTap: () => ThemeSelectionDialog.show(context),
    );
  }
}
