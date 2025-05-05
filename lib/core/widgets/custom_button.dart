import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String icon;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.icon = AssetsManager.arrow,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ThemeManager.elevatedButtonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(width: SizesManager.padding),
            SvgPicture.asset(icon),
          ],
        ),
      ),
    );
  }
}
