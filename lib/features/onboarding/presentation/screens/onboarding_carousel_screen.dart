import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/colors_manager.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:freud_ai/features/onboarding/presentation/widgets/bottom_navigation.dart';
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
        body: Padding(
          padding: const EdgeInsets.only(top: SizesManager.padding),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              MorphingSvg(currentIndex: currentIndex, isDarkMode: isDarkMode),
              SafeArea(
                child: OutlinedButton(
                  onPressed: null,
                  style: ThemeManager.outlinedButtonStyle,
                  child: Text(
                    StringsManager.onBoardingTopButton(currentIndex),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              BottomNavigation(
                currentIndex: currentIndex,
                onTap:
                    () => setState(() {
                      currentIndex == 5
                          ? Navigator.of(context).popAndPushNamed(
                            NavigationManager.authenticationScreen,
                          )
                          : currentIndex++;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
