import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class ThirteenthPage extends StatelessWidget {
  const ThirteenthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextStyle textStyle = TextStyle(
      color: theme.colorScheme.onPrimaryContainer,
      fontSize: 30,
      fontWeight: FontWeight.w500,
    );
    return Column(
      spacing: 30,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            StringsManager.assessmentSubtitle13,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        SvgPicture(
          AssetBytesLoader(theme.extension<CustomAssets>()!.page13),
          width: 236,
          height: 236,
        ),
        Column(
          children: [
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: theme.extension<CustomColors>()!.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizesManager.circularBorderRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    child: Text(
                      'I believe in',
                      style: textStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Text("Dr.Freud,", style: textStyle),
              ],
            ),
            Text("With all my heart.", style: textStyle),
          ],
        ),
      ],
    );
  }
}
