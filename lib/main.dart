import 'package:akillisletme/product/init/app_builder.dart';
import 'package:akillisletme/product/init/application_init.dart';
import 'package:akillisletme/product/init/language/core_localize.dart';
import 'package:akillisletme/product/init/state_initialize.dart';
import 'package:akillisletme/product/navigation/app_router.dart';
import 'package:akillisletme/product/theme/state/theme_cubit.dart';
import 'package:akillisletme/product/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await const ApplicationInit().start();
  runApp(
    EasyLocalization(
      supportedLocales: CoreLocalize.supportedItems,
      path: CoreLocalize.initialPath,
      startLocale: CoreLocalize.startLocale,
      useOnlyLangCode: true,
      child: const StateInitialize(child: StarterApp()),
    ),
  );
}

class StarterApp extends StatelessWidget {
  const StarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final variant = context.watch<ThemeCubit>().state;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme(variant),
      theme: AppTheme.lightTheme(variant),
      routerConfig: AppRouter.router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: AppBuilder.call,
    );
  }
}
