import 'package:flutter/material.dart';

/// A circular progress indicator with center text
class CircularMetricIndicator extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String value;
  final String label;
  final Color color;
  final Color backgroundColor;
  final double size;

  const CircularMetricIndicator({
    super.key,
    required this.progress,
    required this.value,
    required this.label,
    required this.color,
    this.backgroundColor = const Color(0xFFF2F4EA),
    this.size = 120,
  }) : assert(progress >= 0.0 && progress <= 1.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background circle
        Container(
          width: size,
          height: size,
          decoration: ShapeDecoration(
            shape: OvalBorder(
              side: BorderSide(
                width: 10,
                color: backgroundColor,
              ),
            ),
          ),
        ),
        // Progress circle
        Transform.rotate(
          angle: -3.14159 / 2, // Start from top
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        // Center text
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFF2F4EA),
                fontSize: 24,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w800,
                letterSpacing: -0.24,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE5EAD6),
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                letterSpacing: -0.14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
