import 'package:akillisletme/product/theme/app_theme_variant.dart';
import 'package:akillisletme/product/theme/state/theme_cubit.dart';
import 'package:akillisletme/product/utils/responsive_extension.dart';
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
    final current = context.watch<ThemeCubit>().state;
    return AlertDialog(
      title: Text('Choose Theme', style: TextStyle(fontSize: context.rf(22))),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: context.r(12),
            crossAxisSpacing: context.r(12),
            childAspectRatio: 0.85,
          ),
          itemCount: AppThemeVariant.values.length,
          itemBuilder: (context, index) {
            final variant = AppThemeVariant.values[index];
            final isSelected = variant == current;
            return _VariantCard(
              variant: variant,
              isSelected: isSelected,
              onTap: () {
                context.read<ThemeCubit>().setVariant(variant);
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
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
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(context.r(14)),
          border: Border.all(
            color: isSelected ? variant.previewColor : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: context.r(44),
                  height: context.r(44),
                  decoration: BoxDecoration(
                    color: variant.previewColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: context.r(24),
                  ),
              ],
            ),
            SizedBox(height: context.r(8)),
            Text(
              variant.label,
              style: TextStyle(
                fontSize: context.rf(13),
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
