import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playground/core/managers/assets_manager.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';
import 'package:playground/core/managers/strings_manager.dart';
import 'package:playground/core/managers/theme_manager.dart';

class OnboardingFirstScreen extends StatelessWidget {
  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: SizesManager.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsManager.icon),
            Padding(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: ThemeManager.titleTheme,
                        text: StringsManager.onBoardingFirstTitle1,
                        children: [
                          TextSpan(
                            text: StringsManager.onBoardingFirstTitle2,
                            style: ThemeManager.titleTheme.copyWith(
                              color: ColorsManager.primaryLight,
                            ),
                          ),
                          TextSpan(
                            text: StringsManager.onBoardingFirstTitle3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  StringsManager.onBoardingFirstSubtitle,
                  style: ThemeManager.subtitleTheme,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: SizesManager.padding),
              child: SvgPicture.asset(AssetsManager.onBoarding0),
            ),
            Padding(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  foregroundColor: ColorsManager.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: SizesManager.padding,
                    horizontal: SizesManager.dPadding,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      StringsManager.getStarted,
                      style: ThemeManager.buttonTextTheme,
                    ),
                    const SizedBox(width: SizesManager.padding),
                    SvgPicture.asset(AssetsManager.arrow),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: SizesManager.padding),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: StringsManager.alreadyHaveAnAccount,
                      style: ThemeManager.smallTextTheme.copyWith(
                        color: ColorsManager.secondary,
                      ),
                      children: [
                        TextSpan(
                          text: StringsManager.signIn,
                          style: ThemeManager.smallTextTheme.copyWith(
                            color: ColorsManager.orange,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
