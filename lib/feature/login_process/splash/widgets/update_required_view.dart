part of '../splash_view.dart';

class _UpdateRequiredView extends StatelessWidget {
  const _UpdateRequiredView({
    required this.currentVersion,
    required this.minimumVersion,
  });

  final String currentVersion;
  final String minimumVersion;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPaddings.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: cs.onSurface.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.upgrade_rounded,
                size: 40,
                color: cs.error,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              LocaleKeys.update_required.tr(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.update_message.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: cs.onSurface.withValues(alpha: 0.6),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'v$currentVersion → v$minimumVersion',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'monospace',
                color: cs.onSurface.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 40),
            AppPrimaryButton(
              label: LocaleKeys.update_button.tr(),
              onPressed: _openStore,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openStore() async {
    final isApple = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
    final url = isApple ? AppString.appStoreUrl : AppString.playStoreUrl;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
