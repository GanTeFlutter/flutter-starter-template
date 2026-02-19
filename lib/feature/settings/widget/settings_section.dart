import 'package:akillisletme/product/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

/// Ayarlar sayfasindaki gruplar icin seffaf kart.
/// [title] opsiyonel baslik, [children] icindeki tile'lar listelenir.
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.children,
    super.key,
    this.title,
  });

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(
              left: context.r(16),
              bottom: context.r(8),
            ),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: context.rf(13),
                fontWeight: FontWeight.w600,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(context.r(16)),
            border: Border.all(
              color: cs.outlineVariant.withValues(alpha: 0.2),
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
