import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/twelfth_page/widgets/circle_button.dart';

class NumberRow extends StatelessWidget {
  const NumberRow({
    super.key,
    required this.theme,
    required this.selectedIndex,
    required this.onTap,
  });
  final ThemeData theme;
  final int selectedIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Card(
        elevation: 0,
        color: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                5,
                (index) => CircleButton(
                  theme: theme,
                  text: '${index + 1}',
                  isSelected: index == selectedIndex,
                  onTap: () => onTap(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
