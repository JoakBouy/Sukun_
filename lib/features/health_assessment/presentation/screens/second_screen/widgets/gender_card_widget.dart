import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
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
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 0,
            children: [
              Padding(
                padding: const EdgeInsets.all(SizesManager.padding + 2),
                child: SizedBox(
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isMale ? StringsManager.male : StringsManager.female,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SvgPicture.asset(
                        isMale
                            ? Theme.of(
                              context,
                            ).extension<CustomAssets>()!.maleIcon
                            : Theme.of(
                              context,
                            ).extension<CustomAssets>()!.femaleIcon,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(SizesManager.cardCircularBorderRadius),
              bottomRight: Radius.circular(
                SizesManager.cardCircularBorderRadius,
              ),
            ),
            child: SvgPicture.asset(
              height: 180,
              width: MediaQuery.sizeOf(context).width / 1.65,
              isMale
                  ? Theme.of(context).extension<CustomAssets>()!.male
                  : Theme.of(context).extension<CustomAssets>()!.female,
            ),
          ),
        ],
      ),
    );
  }
}
