import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class YesNoCard extends StatelessWidget {
  const YesNoCard({
    super.key,
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
  final bool selected;
  final String title;
  final String subtitle;
  final String icon;
  final void Function(bool?) onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      height: 180,
      width: 600,
      child: Card(
        color:
            selected
                ? theme.colorScheme.secondary
                : theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
        ),
        child: RadioListTile(
          activeColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          title: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SizesManager.hPadding + 2,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: SizesManager.hPadding + 2,
              children: [
                SvgPicture.asset(
                  width: 48,
                  height: 48,
                  icon,
                  colorFilter: ColorFilter.mode(
                    selected ? Colors.white : theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color:
                        selected ? Colors.white : theme.colorScheme.onSurface,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color:
                  selected
                      ? Colors.white
                      : theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          value: selected,
          groupValue: true,
          onChanged: onTap,
        ),
      ),
    );
  }
}
