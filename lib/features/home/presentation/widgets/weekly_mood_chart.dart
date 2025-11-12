import 'package:flutter/material.dart';

/// Weekly mood chart with colored bars
/// Based on mood reference design with day labels and colored bars
class WeeklyMoodChart extends StatelessWidget {
  final List<double> moodValues; // 7 values for 7 days
  final List<String> dayLabels; // ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

  const WeeklyMoodChart({
    super.key,
    required this.moodValues,
    this.dayLabels = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 40,
        children: [
          // Horizontal lines for chart background
          ...List.generate(
            6,
            (index) => Container(
              width: 343,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: const Color(0xFFE7DDD8),
                  ),
                  borderRadius: BorderRadius.circular(1234),
                ),
              ),
            ),
          ),
          // Mood bars
          SizedBox(
            width: 343,
            height: 200,
            child: Stack(
              children: [
                // Bars positioned from bottom
                ...List.generate(
                  7,
                  (index) => Positioned(
                    left: index * 48.0, // 343 / 7 ≈ 49, but adjusted for spacing
                    bottom: 0,
                    child: _buildMoodBar(moodValues[index], index),
                  ),
                ),
              ],
            ),
          ),
          // Day labels
          Container(
            width: 343,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: dayLabels.map((day) => Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      day,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0x7A1F160F),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.14,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodBar(double value, int index) {
    final normalizedValue = value.clamp(0.0, 1.0);
    final height = 40 + (normalizedValue * 160); // 40 to 200
    final color = _getMoodColor(normalizedValue);

    return Container(
      width: 36,
      height: height,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1234),
            topRight: Radius.circular(1234),
          ),
        ),
      ),
    );
  }

  Color _getMoodColor(double value) {
    if (value >= 0.8) return const Color(0xFF9BB068); // Happy - Green
    if (value >= 0.6) return const Color(0xFFFFCE5B); // Good - Yellow
    if (value >= 0.4) return const Color(0xFFFE804B); // Neutral - Orange
    return const Color(0xFFE7DDD8); // Sad - Gray
  }
}
