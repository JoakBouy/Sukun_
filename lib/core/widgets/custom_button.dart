import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/colors_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String icon;
  final Color? color;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.icon = AssetsManager.arrow,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 600,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ThemeManager.elevatedButtonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(
            color?.withAlpha(60) ?? ColorsManager.primary,
          ),
          elevation: WidgetStatePropertyAll(0),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: SizesManager.hPadding,
          runSpacing: SizesManager.hPadding,
          children: [
            Text(
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.fade,
              text,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: color ?? ColorsManager.white,
              ),
            ),
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                color ?? ColorsManager.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
