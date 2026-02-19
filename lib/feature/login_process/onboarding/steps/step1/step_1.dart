import 'package:akillisletme/product/const/app_paddings.dart';
import 'package:flutter/material.dart';

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
              const Spacer(),
              Text(
                'Step 1',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8, width: double.infinity),
              Text(
                'Buraya icerik ekleyin',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
