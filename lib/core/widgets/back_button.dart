import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
          border: Border.all(color: theme.colorScheme.onSurface, width: 1.3),
        ),
        child: SvgPicture(
          AssetBytesLoader(theme.extension<CustomAssets>()!.back),
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(
            theme.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
