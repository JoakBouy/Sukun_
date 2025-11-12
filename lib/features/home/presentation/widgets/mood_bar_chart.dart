import 'package:flutter/material.dart';

/// Bar chart visualization for mood trends
/// Shows mood data with color-coded bars
class MoodBarChart extends StatelessWidget {
  final List<double> moodValues;
  final Color primaryColor;
  final Color secondaryColor;

  const MoodBarChart({
    super.key,
    required this.moodValues,
    this.primaryColor = const Color(0xFFFEAE8F),
    this.secondaryColor = const Color(0xFFFEEFEA),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 131,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          moodValues.length.clamp(0, 12),
          (index) => Padding(
            padding: EdgeInsets.only(right: index < moodValues.length - 1 ? 3 : 0),
            child: _buildBar(moodValues[index], index),
          ),
        ),
      ),
    );
  }

  Widget _buildBar(double value, int index) {
    final normalizedValue = value.clamp(0.0, 1.0);
    final height = 5 + (normalizedValue * 57); // 5 to 62
    final isHighlighted = normalizedValue < 0.4;

    return Container(
      width: 8,
      height: height,
      decoration: ShapeDecoration(
        color: isHighlighted ? primaryColor : secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1234),
        ),
      ),
    );
  }
}
