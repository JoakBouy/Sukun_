import 'package:flutter/material.dart';

class LineProgressBar extends StatelessWidget {
  final double progress; // value between 0.0 and 1.0
  final double height;
  final double width;
  final Color backgroundColor;
  final Color progressColor;

  const LineProgressBar({
    super.key,
    required this.progress,
    this.height = 9.0,
    this.width = 200.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: backgroundColor),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
