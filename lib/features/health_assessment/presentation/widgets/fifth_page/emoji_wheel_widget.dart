import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/helpers/widgets_helper.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/fifth_page/SideArchedPainter.dart';

class EmojiWheelWidget extends StatefulWidget {
  const EmojiWheelWidget({super.key});

  @override
  State<EmojiWheelWidget> createState() => _EmojiWheelWidgetState();
}

class _EmojiWheelWidgetState extends State<EmojiWheelWidget> {
  int _selectedIndex = 2;
  final FixedExtentScrollController _controller = FixedExtentScrollController(
    // center the wheel to the middle, 220 is the width of an item and 100 is the number of repeated items
    // (220 * 2) is the offset to center the 5 items
    initialItem: 52,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _selectedIndex = ((_controller.offset) / 220).round() % 5;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<Color> colors = WidgetsHelper.getEmojisColors(theme);
    final List<String> assets = WidgetsHelper.getEmojis(theme);
    final List<String> statues = WidgetsHelper.getEmojisStatue();

    return Column(
      children: [
        Text(
          "I Feel ${statues[_selectedIndex]}",
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
        SvgPicture.asset(width: 120, height: 120, assets[_selectedIndex]),
        SizedBox(height: 20),
        SvgPicture.asset(
          height: 48,
          width: 48,
          theme.extension<CustomAssets>()!.pointer,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: OverflowBox(
                maxWidth: 1000,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: ListWheelScrollView(
                    physics: FixedExtentScrollPhysics(),
                    renderChildrenOutsideViewport: true,
                    clipBehavior: Clip.none,
                    controller: _controller,
                    offAxisFraction: -3.5,
                    squeeze: 1.054,
                    itemExtent: 220,
                    children: [
                      ...repeatWidgets(
                        times: 100,
                        colors: colors,
                        assets: assets,
                      ),
                    ], // repeat the widgets to simulate a wheel
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SvgPicture.asset(
                theme.extension<CustomAssets>()!.wheelSelector,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// repeat the 5 widgets to simulate a wheel
List<Widget> repeatWidgets({
  required int times,
  required List<Color> colors,
  required List<String> assets,
}) {
  final base = List.generate(5, (index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 300,
          width: 200,
          child: CustomPaint(
            key: Key(index.toString()),
            painter: SideArchedPainter(color: colors[index]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: RotatedBox(
            quarterTurns: -1,
            child: SvgPicture.asset(width: 120, height: 120, assets[index]),
          ),
        ),
      ],
    );
  });
  return List.generate(times, (_) => base).expand((e) => e).toList();
}
