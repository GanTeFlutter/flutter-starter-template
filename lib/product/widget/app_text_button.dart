import 'package:akillisletme/product/utils/button_feedback.dart';
import 'package:akillisletme/product/utils/responsive_extension.dart';
import 'package:flutter/material.dart';


/// Minimal/text buton — TextButton tabanli.
/// "Temizle, sil" gibi hafif aksiyonlar icin.
class AppTextButton extends StatelessWidget {

  const AppTextButton({
    required this.label, super.key,
    this.onPressed,
    this.color,
  });
  final String label;
  final VoidCallback? onPressed;
  final Color? color;

  VoidCallback? get _wrappedOnPressed => onPressed != null
      ? () {
          ButtonFeedback.trigger();
          onPressed!();
        }
      : null;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _wrappedOnPressed,
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: context.rf(14),
        ),
      ),
    );
  }
}
