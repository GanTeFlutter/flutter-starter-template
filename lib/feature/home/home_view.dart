import 'package:akillisletme/feature/home/home_view_mode.dart';
import 'package:akillisletme/product/const/app_paddings.dart';
import 'package:akillisletme/product/init/language/locale_keys.g.dart';
import 'package:akillisletme/product/navigation/app_router.dart';
import 'package:akillisletme/product/utils/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewMode {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_title.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => const SettingsRoute().push<void>(context),
          ),
        ],
      ),
      body: ListView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: context.r(AppPaddings.l),
          vertical: context.r(AppPaddings.s),
        ),
        children: [
          // Baslik
          // Text(
          //   LocaleKeys.general_appName.tr(),
          //   style: Theme.of(context).textTheme.headlineSmall,
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: context.r(AppPaddings.xxl)),

          // // ── FlutterGen Asset ornekleri ──

          // // Image
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(AppPaddings.m),
          //   child: Assets.image.booom.image(
          //     width: double.infinity,
          //     height: 180,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // SizedBox(height: context.r(AppPaddings.m)),

          // // SVG
          // Assets.svg.bomb.svg(
          //   width: 64,
          //   height: 64,
          //   colorFilter: ColorFilter.mode(
          //     Theme.of(context).colorScheme.primary,
          //     BlendMode.srcIn,
          //   ),
          // ),
          // SizedBox(height: context.r(AppPaddings.m)),

          // // Lottie
          // Assets.lottie.backroundAnimation.lottie(
          //   width: double.infinity,
          //   height: 150,
          //   fit: BoxFit.contain,
          // ),
          // SizedBox(height: context.r(AppPaddings.s)),

          // // FontFamily
          // Text(
          //   'Poppins (FlutterGen)',
          //   style: Theme.of(
          //     context,
          //   ).textTheme.bodyLarge?.copyWith(fontFamily: FontFamily.poppins),
          //   textAlign: TextAlign.center,
          // ),
          // Text(
          //   'Inter (FlutterGen)',
          //   style: Theme.of(
          //     context,
          //   ).textTheme.bodyLarge?.copyWith(fontFamily: FontFamily.inter),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: context.r(AppPaddings.xxl)),

          // // ── Buton & Messenger ornekleri ──
          // AppPrimaryButton(
          //   label: 'Success SnackBar',
          //   icon: Icons.check_circle_outline,
          //   onPressed: () => context.showSuccessSnack('Islem basarili!'),
          // ),
          // SizedBox(height: context.r(AppPaddings.m)),

          // AppSecondaryButton(
          //   label: 'Error SnackBar',
          //   icon: Icons.error_outline,
          //   onPressed: () => context.showErrorSnack('Bir hata olustu!'),
          // ),
          // SizedBox(height: context.r(AppPaddings.m)),

          // AppTextButton(
          //   label: 'Info SnackBar',
          //   onPressed: () => context.showInfoSnack('Bilgi mesaji'),
          // ),
          // SizedBox(height: context.r(AppPaddings.xxl)),

          // // Dialog ornegi
          // AppPrimaryButton(
          //   label: 'Confirm Dialog',
          //   icon: Icons.help_outline,
          //   onPressed: () async {
          //     final confirmed = await context.showConfirmDialog(
          //       title: 'Silmek istediginize emin misiniz?',
          //       message: 'Bu islem geri alinamaz.',
          //       isDestructive: true,
          //     );
          //     if (confirmed && context.mounted) {
          //       context.showSuccessSnack('Silindi!');
          //     }
          //   },
          // ),
          // SizedBox(height: context.r(AppPaddings.m)),

          // // Bottom Sheet ornegi
          // AppSecondaryButton(
          //   label: 'Bottom Sheet',
          //   icon: Icons.expand_less,
          //   onPressed: () {
          //     context.showAppBottomSheet<void>(
          //       child: Padding(
          //         padding: AppPaddings.allXxl,
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Text(
          //               'Bottom Sheet Ornegi',
          //               style: Theme.of(context).textTheme.titleLarge,
          //             ),
          //             SizedBox(height: context.r(AppPaddings.l)),
          //             Text(
          //               'Buraya istediginiz icerigi ekleyebilirsiniz.',
          //               style: Theme.of(context).textTheme.bodyMedium,
          //               textAlign: TextAlign.center,
          //             ),
          //             SizedBox(height: context.r(AppPaddings.xxl)),
          //             AppPrimaryButton(
          //               label: 'Kapat',
          //               onPressed: () => Navigator.of(context).pop(),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
