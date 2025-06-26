import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class EmojiWheelWidget extends StatefulWidget {
  const EmojiWheelWidget({super.key});

  @override
  State<EmojiWheelWidget> createState() => _EmojiWheelWidgetState();
}

class _EmojiWheelWidgetState extends State<EmojiWheelWidget> {
  final ScrollController _controller = ScrollController(
    // center the wheel to the middle, 220 is the width of an item and 100 is the number of repeated items
    // (220 * 2) is the offset to center the 5 items
    initialScrollOffset: (220 * 2) + (220 * 100),
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // background colors
    final List<Color> colors = [
      theme.extension<CustomColors>()!.green,
      Color.fromRGBO(252, 208, 100, 1),
      Color.fromRGBO(188, 160, 145, 1),
      theme.extension<CustomColors>()!.orange,
      theme.extension<CustomColors>()!.violet,
    ];
    // the faces of the wheel
    final List<String> assets = [
      theme.extension<CustomAssets>()!.emoji1,
      theme.extension<CustomAssets>()!.emoji2,
      theme.extension<CustomAssets>()!.emoji3,
      theme.extension<CustomAssets>()!.emoji4,
      theme.extension<CustomAssets>()!.emoji5,
    ];
    // repeat the 5 widgets to simulate a wheel
    List<Widget> repeatWidgets(int times) {
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

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 240),
          child: OverflowBox(
            maxWidth: 1000,
            child: RotatedBox(
              quarterTurns: 1,
              child: ListWheelScrollView(
                controller: _controller,
                offAxisFraction: -3.5,
                squeeze: 1.054,
                itemExtent: 220,
                children: [
                  ...repeatWidgets(100),
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
    );
  }
}

// this painter is used to create the arched rectangle shape that is used in the wheel
class SideArchedPainter extends CustomPainter {
  final Color color;
  SideArchedPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    const archWidth = 20.0;

    final path = Path();

    // Start at top-left
    path.moveTo(archWidth, 0);

    // Top edge
    path.lineTo(size.width - archWidth, 0);

    // Right arch
    path.quadraticBezierTo(
      size.width - archWidth * 2 - 10,
      size.height / 2,
      size.width - archWidth,
      size.height,
    );
    // Bottom edge
    path.lineTo(archWidth, size.height);

    // Left arch
    path.quadraticBezierTo(archWidth / 2 - 22, size.height / 2, archWidth, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
