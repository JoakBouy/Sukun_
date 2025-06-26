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
    initialScrollOffset: 440,
  );
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<Color> colors = [
      theme.extension<CustomColors>()!.green,
      Color.fromRGBO(252, 208, 100, 1),
      Color.fromRGBO(188, 160, 145, 1),
      theme.extension<CustomColors>()!.orange,
      theme.extension<CustomColors>()!.violet,
    ];
    final List<String> assets = [
      theme.extension<CustomAssets>()!.emoji1,
      theme.extension<CustomAssets>()!.emoji2,
      theme.extension<CustomAssets>()!.emoji3,
      theme.extension<CustomAssets>()!.emoji4,
      theme.extension<CustomAssets>()!.emoji5,
    ];
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
                  ...List.generate(5, (index) {
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
                            child: SvgPicture.asset(
                              width: 120,
                              height: 120,
                              assets[index],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
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
