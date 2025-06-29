import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;
  final int? divisions;
  final double trackHeight;
  final Widget? thumb;
  final Color trackColor;
  final Color activeTrackColor;
  final Color divisionColor;

  const CustomSlider({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    this.divisions,
    this.trackHeight = 4,
    this.thumb,
    this.trackColor = Colors.grey,
    this.activeTrackColor = Colors.blue,
    this.divisionColor = Colors.black26,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _localValue;

  @override
  void initState() {
    super.initState();
    _localValue = widget.value;
  }

  void _updateValue(Offset localPosition, double width) {
    double dx = localPosition.dx.clamp(0.0, width);
    double percent = dx / width;
    double rawValue = widget.min + (widget.max - widget.min) * percent;

    if (widget.divisions != null && widget.divisions! > 0) {
      double step = (widget.max - widget.min) / widget.divisions!;
      rawValue = ((rawValue - widget.min) / step).round() * step + widget.min;
    }

    rawValue = rawValue.clamp(widget.min, widget.max);

    setState(() => _localValue = rawValue);
    widget.onChanged(rawValue);
  }

  @override
  Widget build(BuildContext context) {
    const double thumbSize = 70;
    final double halfThumb = thumbSize / 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth;
        final usableWidth = fullWidth - thumbSize;

        final percent = (_localValue - widget.min) / (widget.max - widget.min);
        final thumbX = percent * usableWidth;

        return SizedBox(
          height: 120,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanDown:
                (details) => _updateValue(
                  Offset(details.localPosition.dx - halfThumb, 0),
                  usableWidth,
                ),
            onPanUpdate:
                (details) => _updateValue(
                  Offset(details.localPosition.dx - halfThumb, 0),
                  usableWidth,
                ),
            child: Stack(
              children: [
                // Track (inactive)
                Positioned(
                  left: halfThumb - 20,
                  right: halfThumb - 20,
                  top: 48,
                  child: Container(
                    height: widget.trackHeight,
                    decoration: BoxDecoration(
                      color: widget.trackColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Track (active)
                Positioned(
                  left: halfThumb - 20,
                  top: 48,
                  child: Container(
                    width: thumbX,
                    height: widget.trackHeight,
                    decoration: BoxDecoration(
                      color: widget.activeTrackColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Tick marks
                if (widget.divisions != null && widget.divisions! > 0)
                  ...List.generate(widget.divisions! + 1, (i) {
                    final x =
                        (i / widget.divisions!) * usableWidth + halfThumb - 1;
                    return Positioned(
                      left: x,
                      top: 48,
                      child: Container(
                        width: 2,
                        height: 16,
                        color: widget.divisionColor,
                      ),
                    );
                  }),

                // Thumb
                Positioned(
                  left: thumbX,
                  top: 20, // might need to adjust
                  child: SizedBox(
                    width: thumbSize,
                    height: thumbSize,
                    child: Center(
                      child:
                          widget.thumb ??
                          Container(
                            width: thumbSize,
                            height: thumbSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// A simpler version of the slider widget using flutters Slider widget

// RotatedBox(
//   quarterTurns: -1,
//   child: SliderTheme(
//     data: SliderTheme.of(context).copyWith(
//       thumbShape: AppSliderShape(thumbRadius: 30),
//       trackHeight: 13,
//       tickMarkShape: SliderTickMarkShape.noTickMark,
//     ),
//     child: Slider(
//       activeColor: Color(0xffc0610a),
//       thumbColor: theme.extension<CustomColors>()!.orange,
//       divisions: 4,
//       secondaryTrackValue: 4,
//       value: _value,
//       onChanged: (value) => setState(() => _value = value),
//       min: 0,
//       max: 4,
//     ),
//   ),
// ),
//
// class AppSliderShape extends SliderComponentShape {
//   final double thumbRadius;
//
//   const AppSliderShape({required this.thumbRadius});
//
//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//     return Size.fromRadius(thumbRadius);
//   }
//
//   @override
//   void paint(
//       PaintingContext context,
//       Offset center, {
//         required Animation<double> activationAnimation,
//         required Animation<double> enableAnimation,
//         required bool isDiscrete,
//         required TextPainter labelPainter,
//         required RenderBox parentBox,
//         required SliderThemeData sliderTheme,
//         required TextDirection textDirection,
//         required double value,
//         required double textScaleFactor,
//         required Size sizeWithOverflow,
//       }) {
//     final Canvas canvas = context.canvas;
//
//     final paint =
//     Paint()
//       ..style = PaintingStyle.fill
//       ..color = sliderTheme.thumbColor!;
//
//     // draw icon with text painter
//     const iconData = Icons.circle_outlined;
//     final TextPainter textPainter = TextPainter(
//       textDirection: TextDirection.rtl,
//     );
//     textPainter.text = TextSpan(
//       text: String.fromCharCode(iconData.codePoint),
//       style: TextStyle(
//         fontSize: thumbRadius / 2,
//         fontFamily: iconData.fontFamily,
//         color: Colors.white,
//       ),
//     );
//     textPainter.layout();
//
//     final Offset textCenter = Offset(
//       center.dx - (textPainter.width / 2),
//       center.dy - (textPainter.height / 2),
//     );
//     const cornerRadius = 40.0;
//
//     // draw the background shape here..
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromCenter(
//           center: center,
//           width: thumbRadius * 2,
//           height: thumbRadius * 2,
//         ),
//         Radius.circular(cornerRadius),
//       ),
//       paint,
//     );
//
//     textPainter.paint(canvas, textCenter);
//   }
// }
