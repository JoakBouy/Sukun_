import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:playground/core/managers/assets_manager.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/navigation_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';
import 'package:playground/core/managers/strings_manager.dart';
import 'package:playground/core/managers/theme_manager.dart';

class OnboardingFirstScreen extends StatefulWidget {
  const OnboardingFirstScreen({super.key});
  @override
  State<OnboardingFirstScreen> createState() => _OnboardingFirstScreenState();
}

class _OnboardingFirstScreenState extends State<OnboardingFirstScreen> {
  late String isDarkMode;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? 'dark'
            : 'light';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: SizesManager.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AssetsManager.getIcon(isDarkMode)),
                Padding(
                  padding: const EdgeInsets.all(SizesManager.padding),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: Theme.of(context).textTheme.titleLarge,
                            text: StringsManager.onBoardingFirstTitle1,
                            children: [
                              TextSpan(
                                text: StringsManager.onBoardingFirstTitle2,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: SizesManager.padding),
                  child: SvgPicture.asset(
                    AssetsManager.getOnboarding(isDarkMode, 0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizesManager.padding),
                  child: ElevatedButton(
                    onPressed:
                        () => context.pushNamedTransition(
                          routeName: NavigationManager.onboardingCarouselScreen,
                          type: PageTransitionType.sharedAxisHorizontal,
                        ),
                    style: ThemeManager.elevatedButtonStyle,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          StringsManager.getStarted,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(width: SizesManager.padding),
                        SvgPicture.asset(AssetsManager.arrow),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: SizesManager.padding),
                  child: GestureDetector(
                    onTap:
                        () => Navigator.of(context).pushNamed(
                          NavigationManager.authenticationScreen,
                        ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: StringsManager.alreadyHaveAnAccount,
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: StringsManager.signIn,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall!.copyWith(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
