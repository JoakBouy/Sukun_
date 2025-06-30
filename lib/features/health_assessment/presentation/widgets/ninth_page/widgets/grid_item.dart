import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.theme,
  });
  final void Function() onTap;
  final bool isSelected;
  final String title;
  final String icon;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color:
                isSelected
                    ? theme.extension<CustomColors>()!.green.withAlpha(60)
                    : theme.colorScheme.primaryContainer,
            width: 4,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          color:
              isSelected
                  ? theme.extension<CustomColors>()!.green
                  : theme.colorScheme.primaryContainer,
        ),
        child: Padding(
          padding: EdgeInsets.all(SizesManager.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : theme.colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  color:
                      isSelected ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
