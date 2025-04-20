import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playground/core/managers/assets_manager.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';
import 'package:playground/core/managers/strings_manager.dart';
import 'package:playground/core/managers/theme_manager.dart';
import 'package:playground/features/onboarding/presentation/widgets/LineProgressBar.dart';

class OnboardingCarouselScreen extends StatefulWidget {
  const OnboardingCarouselScreen({super.key});
  @override
  State<OnboardingCarouselScreen> createState() =>
      _OnboardingCarouselScreenState();
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen> {
  int currentIndex = 1;
  late String isDarkMode;
  late final double height = MediaQuery.of(context).size.height;
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
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: SizesManager.padding),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SvgPicture.asset(
                        AssetsManager.getOnboarding(isDarkMode, currentIndex),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitHeight,
                        allowDrawingOutsideViewBox: false,
                        height: height * 1.7,
                        clipBehavior: Clip.hardEdge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(SizesManager.dhPadding),
                      child: OutlinedButton(
                        onPressed: () {},
                        style:
                            isDarkMode == 'dark'
                                ? ThemeManager.outlinedButtonDarkStyle
                                : ThemeManager.outlinedButtonLightStyle,
                        child: Text(
                          StringsManager.onBoardingTopButton(currentIndex),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height / 1.6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(SizesManager.padding),
                        child: LineProgressBar(
                          progress: (0 + currentIndex * 0.2),
                          backgroundColor: ColorsManager.secondaryLight,
                          progressColor: ColorsManager.getAccentColor(
                            currentIndex,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(SizesManager.padding),
                        child: RichText(
                          maxLines: 2,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(SizesManager.padding),
                        child: ElevatedButton(
                          onPressed:
                              () => setState(() {
                                currentIndex == 5 ? null : currentIndex++;
                              }),
                          style: ThemeManager.circularElevatedButtonStyle,
                          child: SvgPicture.asset(AssetsManager.arrow2),
                        ),
                      ),
                    ],
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
