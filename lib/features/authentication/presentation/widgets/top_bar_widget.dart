import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          color: Theme.of(context).extension<CustomColors>()!.green,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: SizesManager.dhPadding),
          child: SvgPicture.asset(AssetsManager.iconWhite, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
