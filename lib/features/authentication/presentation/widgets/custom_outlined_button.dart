import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.icon,
    required this.theme,
  });
  final String icon;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:
          () => Navigator.of(
            context,
          ).pushNamed(NavigationManager.assessmentMainScreen),
      style: ThemeManager.circularOutlinedButtonStyle,
      child: SvgPicture(
        AssetBytesLoader(icon),
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          theme.colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
