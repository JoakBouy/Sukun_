import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

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
    return Card(
      elevation: !selected ? 0 : 6,
      shadowColor: Theme.of(context).extension<CustomColors>()!.green,
      color: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        side:
            !selected
                ? BorderSide.none
                : BorderSide(
                  color:
                      Theme.of(context).extension<CustomColors>()!.greenAccent,
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
            SizedBox(
              width:
                  MediaQuery.sizeOf(context).width * 0.4 > 400
                      ? 400
                      : MediaQuery.sizeOf(context).width * 0.4,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
