import 'package:flutter/material.dart';

/// Calendar grid visualization for tracking activities
/// Shows a grid of days with color-coded status
class CalendarGrid extends StatelessWidget {
  final List<CalendarDayStatus> days;
  final Color activeColor;
  final Color inactiveColor;
  final Color partialColor;

  const CalendarGrid({
    super.key,
    required this.days,
    this.activeColor = const Color(0xFFCAC1FF),
    this.inactiveColor = Colors.white,
    this.partialColor = const Color(0xFFEDEAFF),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 131,
      height: 101,
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.center,
        spacing: 4,
        runSpacing: 4,
        children: days.take(28).map((day) => _buildDay(day)).toList(),
      ),
    );
  }

  Widget _buildDay(CalendarDayStatus status) {
    Color color;
    switch (status) {
      case CalendarDayStatus.active:
        color = activeColor;
        break;
      case CalendarDayStatus.partial:
        color = partialColor;
        break;
      case CalendarDayStatus.inactive:
        color = inactiveColor;
        break;
    }

    return Container(
      width: 16,
      height: 16,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

/// Status for each day in the calendar grid
enum CalendarDayStatus {
  active,
  partial,
  inactive,
}
