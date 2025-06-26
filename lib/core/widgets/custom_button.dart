import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? icon;
  final Color? color;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      height: 60,
      width: 600,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ThemeManager.elevatedButtonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(
            color?.withAlpha(60) ?? theme.colorScheme.primary,
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
              style: theme.textTheme.displaySmall?.copyWith(
                color: color ?? Colors.white,
              ),
            ),
            SvgPicture.asset(
              width: 24,
              icon ?? theme.extension<CustomAssets>()!.arrow,
              colorFilter: ColorFilter.mode(
                color ?? Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
