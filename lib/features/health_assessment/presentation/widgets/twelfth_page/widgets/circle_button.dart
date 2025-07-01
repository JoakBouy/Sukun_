import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.theme,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });
  final ThemeData theme;
  final String text;
  final bool isSelected;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected
                  ? theme.extension<CustomColors>()!.orange
                  : Colors.white,
          border: Border.all(
            color:
                isSelected
                    ? theme.extension<CustomColors>()!.orangeAccent
                    : Colors.white,
            width: 4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
