import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

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
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    return Card(
      elevation: !selected ? 0 : 6,
      shadowColor: theme.extension<CustomColors>()!.green,
      color: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        side:
            !selected
                ? BorderSide.none
                : BorderSide(
                  color: theme.extension<CustomColors>()!.greenAccent,
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
              child: SvgPicture(
                AssetBytesLoader(iconPath),
                width: 96,
                height: 96,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: size.width * 0.4 > 400 ? 400 : size.width * 0.4,
              child: Text(title, style: theme.textTheme.displayMedium),
            ),
          ],
        ),
      ),
    );
  }
}
