import 'package:akillisletme/product/init/language/locale_keys.g.dart';
import 'package:akillisletme/product/theme/app_theme_variant.dart';
import 'package:akillisletme/product/theme/state/theme_cubit.dart';
import 'package:akillisletme/product/theme/state/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSelectionDialog extends StatelessWidget {
  const ThemeSelectionDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ThemeCubit>(),
        child: const ThemeSelectionDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            LocaleKeys.settings_chooseTheme.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildVariantGrid(context, state),
              const SizedBox(height: 16),
              _buildThemeModeSelector(context, state),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: cs.primary)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVariantGrid(BuildContext context, ThemeState state) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AppThemeVariant.values.map((variant) {
        final isSelected = variant == state.variant;
        return _VariantCard(
          variant: variant,
          isSelected: isSelected,
          onTap: () => context.read<ThemeCubit>().setVariant(variant),
        );
      }).toList(),
    );
  }

  Widget _buildThemeModeSelector(BuildContext context, ThemeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.settings_themeMode.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.maxFinite,
          child: SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text(
                  LocaleKeys.settings_themeModeSystem.tr(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text(
                  LocaleKeys.settings_themeModeLight.tr(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text(
                  LocaleKeys.settings_themeModeDark.tr(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
            selected: {state.themeMode},
            onSelectionChanged: (modes) {
              context.read<ThemeCubit>().setThemeMode(modes.first);
            },
          ),
        ),
      ],
    );
  }
}

class _VariantCard extends StatelessWidget {
  const _VariantCard({
    required this.variant,
    required this.isSelected,
    required this.onTap,
  });
  final AppThemeVariant variant;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? variant.previewColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: variant.previewColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              variant.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? variant.previewColor
                        : Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
