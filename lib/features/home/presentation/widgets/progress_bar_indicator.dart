import 'package:flutter/material.dart';

/// A simple progress bar component with customizable appearance
class ProgressBarIndicator extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color color;
  final Color backgroundColor;
  final double height;
  final bool showLabel;
  final String? label;

  const ProgressBarIndicator({
    super.key,
    required this.progress,
    required this.color,
    this.backgroundColor = const Color(0xFFE7DDD8),
    this.height = 6,
    this.showLabel = false,
    this.label,
  }) : assert(progress >= 0.0 && progress <= 1.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: height,
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        if (showLabel && label != null) ...[
          const SizedBox(height: 4),
          Text(
            label!,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
