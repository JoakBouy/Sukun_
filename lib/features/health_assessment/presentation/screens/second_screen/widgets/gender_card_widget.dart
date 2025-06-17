import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';

class GenderCardWidget extends StatelessWidget {
  const GenderCardWidget({
    super.key,
    required this.isSelected,
    required this.isMale,
  });
  final bool isSelected;
  final bool isMale;

  @override
  Widget build(BuildContext context) {
    final String isDarkTheme =
        Theme.of(context).brightness == Brightness.dark ? "dark" : "light";
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color:
              isSelected
                  ? isDarkTheme == "dark"
                      ? Colors.white.withAlpha(120)
                      : Theme.of(context).colorScheme.primary.withAlpha(60)
                  : Colors.transparent,
          width: isSelected ? 4 : 0,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(
          SizesManager.cardCircularBorderRadius,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 0,
        children: [
          Padding(
            padding: const EdgeInsets.all(SizesManager.padding + 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMale ? StringsManager.male : StringsManager.female,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: SvgPicture.asset(
                    isMale ? AssetsManager.maleIcon : AssetsManager.femaleIcon,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onPrimaryContainer,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(SizesManager.cardCircularBorderRadius),
              bottomRight: Radius.circular(
                SizesManager.cardCircularBorderRadius,
              ),
            ),
            child: SvgPicture.asset(
              isMale
                  ? AssetsManager.getMale(isDarkTheme)
                  : AssetsManager.getFemale(isDarkTheme),
            ),
          ),
        ],
      ),
    );
  }
}
