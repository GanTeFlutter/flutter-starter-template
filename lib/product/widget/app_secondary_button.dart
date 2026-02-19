import 'package:akillisletme/product/utils/button_feedback.dart';
import 'package:akillisletme/product/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

/// Ikincil aksiyon butonu — OutlinedButton tabanli.
/// "Geri don, tut, iptal" gibi ikincil aksiyonlar icin.
class AppSecondaryButton extends StatelessWidget {

  const AppSecondaryButton({
    required this.label, super.key,
    this.onPressed,
    this.icon,
    this.isExpanded = true,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isExpanded;

  VoidCallback? get _wrappedOnPressed => onPressed != null
      ? () {
          ButtonFeedback.trigger();
          onPressed!();
        }
      : null;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final button = icon != null
        ? OutlinedButton.icon(
            onPressed: _wrappedOnPressed,
            icon: Icon(icon, size: context.r(20)),
            label: _label(context),
            style: _style(context, cs),
          )
        : OutlinedButton(
            onPressed: _wrappedOnPressed,
            style: _style(context, cs),
            child: _label(context),
          );

    if (!isExpanded) return button;
    return SizedBox(width: double.infinity, child: button);
  }

  Widget _label(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: context.rf(16), fontWeight: FontWeight.w700),
    );
  }

  ButtonStyle _style(BuildContext context, ColorScheme cs) {
    return OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: context.r(16)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.r(14)),
      ),
      side: BorderSide(color: cs.primary),
    );
  }
}
