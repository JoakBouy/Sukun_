import 'package:flutter/material.dart';
import 'package:freud_ai/core/helpers/widgets_helper.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class WeightSwitcherWidget extends StatelessWidget {
  const WeightSwitcherWidget({
    super.key,
    required this.isLbs,
    required this.setKg,
    required this.setLbs,
  });
  final bool isLbs;
  final void Function() setKg;
  final void Function() setLbs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(SizesManager.padding),
      child: Container(
        height: 60,
        width: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: theme.colorScheme.primaryContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: ElevatedButton(
                  onPressed: () => setKg(),
                  style:
                      !isLbs
                          ? WidgetsHelper.getPressedButtonTheme(theme)
                          : WidgetsHelper.getUnselectedButtonTheme(theme),
                  child: Text(
                    'kg',
                    style:
                        !isLbs
                            ? TextStyle(color: Colors.white)
                            : TextStyle(color: theme.colorScheme.onSurface),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: ElevatedButton(
                  onPressed: () => setLbs(),
                  style:
                      isLbs
                          ? WidgetsHelper.getPressedButtonTheme(theme)
                          : WidgetsHelper.getUnselectedButtonTheme(theme),
                  child: Text(
                    'lbs',
                    style:
                        isLbs
                            ? TextStyle(color: Colors.white)
                            : TextStyle(color: theme.colorScheme.onSurface),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
