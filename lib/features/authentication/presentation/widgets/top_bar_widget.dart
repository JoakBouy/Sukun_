import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playground/core/managers/assets_manager.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -200,
      top: -650,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 800,
        height: 800,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsManager.green,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: SizesManager.dhPadding),
          child: SvgPicture.asset(AssetsManager.iconWhite, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
