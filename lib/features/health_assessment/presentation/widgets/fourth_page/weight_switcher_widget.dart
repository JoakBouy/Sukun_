import 'package:flutter/material.dart';
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
    final ButtonStyle selectedButtonTheme = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: theme.extension<CustomColors>()!.orange,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
        side: BorderSide(
          color: theme.extension<CustomColors>()!.orangeAccent,
          width: 4,
        ),
      ),
    );
    final ButtonStyle unselectedButtonTheme = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: theme.extension<CustomColors>()!.orange,
      shadowColor: Colors.transparent,
    );
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
                    !widget.isLbs ? selectedButtonTheme : unselectedButtonTheme,
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
                    widget.isLbs ? selectedButtonTheme : unselectedButtonTheme,
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
