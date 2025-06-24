import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
          child: SingleChildScrollView(
            child: Column(
              spacing: SizesManager.padding,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AssetsManager.getIcon(isDarkMode)),
                Center(
                  child: RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
                                color:
                                    Theme.of(
                                      context,
                                    ).extension<CustomColors>()!.lightPrimary,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: SizesManager.padding),
                  child: Center(
                    child: Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      StringsManager.onBoardingFirstSubtitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SvgPicture.asset(AssetsManager.getOnboarding(isDarkMode, 0)),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: FractionallySizedBox(
                    widthFactor: 0.65,
                    child: CustomButton(
                      text: StringsManager.getStarted,
                      onPressed:
                          () => context.pushNamedTransition(
                            routeName:
                                NavigationManager.onboardingCarouselScreen,
                            type: PageTransitionType.sharedAxisHorizontal,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: SizesManager.padding),
                  child: GestureDetector(
                    onTap:
                        () => Navigator.of(
                          context,
                        ).pushNamed(NavigationManager.authenticationScreen),
                    child: RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
                                  color:
                                      Theme.of(
                                        context,
                                      ).extension<CustomColors>()!.orange,
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
