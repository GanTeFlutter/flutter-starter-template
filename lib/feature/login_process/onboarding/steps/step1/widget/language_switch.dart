part of '../step_1.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final isTurkish = context.locale.languageCode == 'tr';
    final cs = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'TR',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isTurkish ? cs.primary : cs.onSurfaceVariant,
                fontWeight: isTurkish ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        const SizedBox(width: 8),
        Switch.adaptive(
          value: !isTurkish,
          onChanged: (_) {
            if (isTurkish) {
              context.setLocale(const Locale('en', 'US'));
            } else {
              context.setLocale(const Locale('tr', 'TR'));
            }
          },
        ),
        const SizedBox(width: 8),
        Text(
          'EN',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: !isTurkish ? cs.primary : cs.onSurfaceVariant,
                fontWeight: !isTurkish ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }
}
