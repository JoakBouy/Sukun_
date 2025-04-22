import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';

class ForgotPasswordCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool selected;
  const ForgotPasswordCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: !selected ? 0 : 6,
      shadowColor: ColorsManager.green,
      color: isDarkMode ? ColorsManager.onBackgroundDark : ColorsManager.white,
      shape: RoundedRectangleBorder(
        side:
            !selected
                ? BorderSide.none
                : BorderSide(
                  color:
                      isDarkMode
                          ? ColorsManager.darkGreen
                          : ColorsManager.lightGreen,
                  width: 4,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
        borderRadius: BorderRadius.circular(
          SizesManager.circularBorderRadius * 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SizesManager.padding),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizesManager.padding,
              ),
              child: SvgPicture.asset(iconPath, fit: BoxFit.fill),
            ),
            Text(title, style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
