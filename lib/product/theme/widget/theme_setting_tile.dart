import 'package:akillisletme/product/theme/state/theme_cubit.dart';
import 'package:akillisletme/product/theme/widget/theme_selection_dialog.dart';
import 'package:akillisletme/product/utils/responsive_extension.dart';
import 'package:akillisletme/product/utils/theme_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Uygulama tema secim tile'i.
class ThemeSettingTile extends StatelessWidget {
  const ThemeSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final variant = context.watch<ThemeCubit>().state;
    return GestureDetector(
      onTap: () => ThemeSelectionDialog.show(context),
      child: Container(
        padding: EdgeInsets.all(context.r(20)),
        decoration: context.settingContainerDecoration,
        child: Row(
          children: [
            Icon(
              Icons.palette_rounded,
              color: variant.previewColor,
              size: context.r(32),
            ),
            SizedBox(width: context.r(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Theme',
                    style: TextStyle(
                      fontSize: context.rf(20),
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                  SizedBox(height: context.r(4)),
                  Text(
                    variant.label,
                    style: TextStyle(
                      fontSize: context.rf(14),
                      color: cs.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: context.r(28),
              height: context.r(28),
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
