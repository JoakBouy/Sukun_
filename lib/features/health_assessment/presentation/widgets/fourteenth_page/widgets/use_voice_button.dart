import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class UseVoiceButton extends StatelessWidget {
  const UseVoiceButton({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
          side: BorderSide(
            color: theme.colorScheme.secondary.withAlpha(80),
            width: 4,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture(
            AssetBytesLoader(theme.extension<CustomAssets>()!.icon14_2),
            width: 24,
            height: 24,
          ),
          SizedBox(width: 10),
          Text(
            "Use voice Instead",
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
