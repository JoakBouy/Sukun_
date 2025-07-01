import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class MostCommon extends StatelessWidget {
  const MostCommon({
    super.key,
    required this.theme,
    required this.mostCommon,
    required this.onTap,
  });
  final ThemeData theme;
  final List<String> mostCommon;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizesManager.vPadding),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          Text(
            'Most Common: ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          ...List.generate(
            mostCommon.length,
            (index) => InkWell(
              onTap:
                  () => {onTap(mostCommon[index]), mostCommon.removeAt(index)},
              borderRadius: BorderRadius.circular(
                SizesManager.cardCircularBorderRadius,
              ),
              child: Card(
                color: theme.extension<CustomColors>()!.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SizesManager.cardCircularBorderRadius,
                  ),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      Text(
                        mostCommon[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.close, color: Color(0xFFFFC89E), size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
