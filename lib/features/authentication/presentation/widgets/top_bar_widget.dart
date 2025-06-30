import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return OverflowBox(
      alignment: Alignment.bottomCenter,
      maxWidth: 800,
      maxHeight: 800,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 800,
        height: 800,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.extension<CustomColors>()!.green,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: SizesManager.dhPadding),
          child: SvgPicture(
            AssetBytesLoader(theme.extension<CustomAssets>()!.iconWhite),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
