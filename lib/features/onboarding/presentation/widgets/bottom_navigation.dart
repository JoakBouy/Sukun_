import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/helpers/accent_color_helper.dart';
import 'package:freud_ai/core/helpers/scale_helper.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
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
    final ThemeData theme = Theme.of(context);
    final Color accentColor = AccentColorHelper.getColor(
      widget.currentIndex - 1,
      theme,
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        OverflowBox(
          alignment: Alignment.bottomCenter,
          maxWidth: size.width * 2,
          child: ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.5,
              child: Container(
                width: size.width * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primaryContainer,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Transform.scale(
            scale: ScaleHelper.calculate(size),
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
                    backgroundColor: theme.colorScheme.primary.withAlpha(60),
                    progressColor: accentColor,
                  ),
                  RichText(
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: theme.textTheme.titleLarge,
                          text: StringsManager.onBoardingTitle1(
                            widget.currentIndex,
                          ),
                          children: [
                            TextSpan(
                              text: StringsManager.onBoardingTitle2(
                                widget.currentIndex,
                              ),
                              style: theme.textTheme.titleLarge!.copyWith(
                                color: accentColor,
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
                    child: SvgPicture.asset(
                      theme.extension<CustomAssets>()!.arrow2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
