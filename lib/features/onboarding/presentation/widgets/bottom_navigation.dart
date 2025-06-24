import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/colors_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:freud_ai/features/onboarding/presentation/widgets/progressbar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final void Function() onTap;
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: size.height - 40),
          child: OverflowBox(
            maxWidth: size.width * 1.8 > 1000 ? 1000 : size.width * 1.8,
            maxHeight: size.height,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SizedBox(
            height: size.height / 2.8 < 280 ? 280 : size.height / 2.8,
            width: size.width * 1.6 > 1000 ? 500 : size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: (size.height / 3) * 0.1,
              children: [
                ProgressBar(
                  progress: (0 + widget.currentIndex * 0.2),
                  backgroundColor: ColorsManager.secondaryLight,
                  progressColor: ColorsManager.getAccentColor(
                    widget.currentIndex,
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
                          widget.currentIndex,
                        ),
                        children: [
                          TextSpan(
                            text: StringsManager.onBoardingTitle2(
                              widget.currentIndex,
                            ),
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              color: ColorsManager.getAccentColor(
                                widget.currentIndex,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: StringsManager.onBoardingTitle3(
                              widget.currentIndex,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: widget.onTap,
                  style: ThemeManager.circularElevatedButtonStyle,
                  child: SvgPicture.asset(AssetsManager.arrow2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
