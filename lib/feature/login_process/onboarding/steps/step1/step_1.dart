import 'package:akillisletme/product/const/app_paddings.dart';
import 'package:akillisletme/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'widget/language_switch.dart';

/// Onboarding Step 1
class Step1 extends StatelessWidget {
  const Step1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.allXxl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.onboarding_step1Title.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8, width: double.infinity),
              Text(
                LocaleKeys.onboarding_step1Desc.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const LanguageSwitch(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
