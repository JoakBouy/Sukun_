import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class SelectedRow extends StatelessWidget {
  const SelectedRow({
    super.key,
    required this.theme,
    required this.selected,
    required this.alphabetWords,
    required this.onTap,
  });
  final ThemeData theme;
  final List<bool> selected;
  final List<String> alphabetWords;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    Map<int, String> currentlySelected = {};
    for (int i = 0; i < selected.length; i++) {
      if (selected[i]) {
        currentlySelected[i] = alphabetWords[i];
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizesManager.vPadding),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        spacing: 12,
        children: [
          Text('Selected: ', style: TextStyle(fontWeight: FontWeight.w600)),
          ...List.generate(
            currentlySelected.length,
            (index) => InkWell(
              onTap: () => onTap(currentlySelected.keys.toList()[index]),
              borderRadius: BorderRadius.circular(
                SizesManager.cardCircularBorderRadius,
              ),
              child: Card(
                color: theme.extension<CustomColors>()!.lightPrimary.withAlpha(
                  60,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SizesManager.cardCircularBorderRadius,
                  ),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      Text(
                        currentlySelected.values.toList()[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Icon(
                        Icons.close,
                        color: theme.extension<CustomColors>()!.lightPrimary,
                        size: 18,
                      ),
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
