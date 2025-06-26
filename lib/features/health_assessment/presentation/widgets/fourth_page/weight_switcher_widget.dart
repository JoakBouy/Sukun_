import 'package:flutter/material.dart';
import 'package:freud_ai/core/helpers/widgets_helper.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class WeightSwitcherWidget extends StatefulWidget {
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
  State<WeightSwitcherWidget> createState() => _WeightSwitcherWidgetState();
}

class _WeightSwitcherWidgetState extends State<WeightSwitcherWidget> {
  late ThemeData theme;
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context);
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.065,
      width: size.width * 0.9,
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
                onPressed: () => widget.setKg(),
                style:
                    !widget.isLbs
                        ? WidgetsHelper.getPressedButtonTheme(theme)
                        : WidgetsHelper.getUnselectedButtonTheme(theme),
                child: Text(
                  'kg',
                  style:
                      !widget.isLbs
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
                onPressed: () => widget.setLbs(),
                style:
                    widget.isLbs
                        ? WidgetsHelper.getPressedButtonTheme(theme)
                        : WidgetsHelper.getUnselectedButtonTheme(theme),
                child: Text(
                  'lbs',
                  style:
                      widget.isLbs
                          ? TextStyle(color: Colors.white)
                          : TextStyle(color: theme.colorScheme.onSurface),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
