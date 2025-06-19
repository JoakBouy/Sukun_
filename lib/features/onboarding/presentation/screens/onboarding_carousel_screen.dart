import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/colors_manager.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:freud_ai/features/onboarding/presentation/widgets/progressbar.dart';
import 'package:freud_ai/features/onboarding/presentation/widgets/morphing_svg.dart';

class OnboardingCarouselScreen extends StatefulWidget {
  const OnboardingCarouselScreen({super.key});
  @override
  State<OnboardingCarouselScreen> createState() =>
      _OnboardingCarouselScreenState();
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen> {
  int currentIndex = 1;
  late String isDarkMode;
  late double height;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    height = MediaQuery.of(context).size.height;
    isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? 'dark'
            : 'light';
  }

  @override
  Widget build(BuildContext context) {
    // instead of handling it as multiple pages use index to change data
    return PopScope(
      canPop: currentIndex == 1 ? true : false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          if (currentIndex > 0) {
            setState(() => currentIndex--);
          } else {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        backgroundColor: ColorsManager.getBackgroundColor(
          currentIndex,
          isDarkMode,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: SizesManager.padding),
          child: Stack(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: OverflowBox(
                      alignment: Alignment.topCenter,
                      maxWidth: height < 880 ? 1100 : 1350,
                      maxHeight: height < 880 ? 1100 : 1350,
                      child: MorphingSvg(
                        currentIndex: currentIndex,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SizesManager.dhPadding),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: ThemeManager.outlinedButtonStyle,
                      child: Text(
                        StringsManager.onBoardingTopButton(currentIndex),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height),
                    child: OverflowBox(
                      maxWidth: height < 850 ? 700 : 800,
                      maxHeight: height < 850 ? 700 : 800,
                      child: Container(
                        width: 800, // fixed diameter = minRadius * 2
                        height: 800,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: SizedBox(
                      width: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: SizesManager.dPadding,
                        children: [
                          ProgressBar(
                            progress: (0 + currentIndex * 0.2),
                            backgroundColor: ColorsManager.secondaryLight,
                            progressColor: ColorsManager.getAccentColor(
                              currentIndex,
                            ),
                          ),
                          RichText(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  style: Theme.of(context).textTheme.titleLarge,
                                  text: StringsManager.onBoardingTitle1(
                                    currentIndex,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: StringsManager.onBoardingTitle2(
                                        currentIndex,
                                      ),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge!.copyWith(
                                        color: ColorsManager.getAccentColor(
                                          currentIndex,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: StringsManager.onBoardingTitle3(
                                        currentIndex,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed:
                                () => setState(() {
                                  currentIndex == 5
                                      ? Navigator.of(context).popAndPushNamed(
                                        NavigationManager.authenticationScreen,
                                      )
                                      : currentIndex++;
                                }),
                            style: ThemeManager.circularElevatedButtonStyle,
                            child: SvgPicture.asset(AssetsManager.arrow2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
