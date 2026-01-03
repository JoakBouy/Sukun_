/// Model for mood insights and trend analysis
class MoodInsight {
  final TrendDirection trendDirection;
  final double averageMood;
  final double moodVariability;
  final List<String> recommendations;
  final String summary;
  final List<MoodDataPoint> dataPoints;
  final DateTime startDate;
  final DateTime endDate;

  MoodInsight({
    required this.trendDirection,
    required this.averageMood,
    required this.moodVariability,
    required this.recommendations,
    required this.summary,
    required this.dataPoints,
    required this.startDate,
    required this.endDate,
  });

  /// Get trend description
  String get trendDescription {
    switch (trendDirection) {
      case TrendDirection.improving:
        return 'Your mood has been improving';
      case TrendDirection.declining:
        return 'Your mood has been declining';
      case TrendDirection.stable:
        return 'Your mood has been stable';
      case TrendDirection.volatile:
        return 'Your mood has been fluctuating';
    }
  }

  /// Get variability description
  String get variabilityDescription {
    if (moodVariability < 0.3) {
      return 'very consistent';
    } else if (moodVariability < 0.5) {
      return 'moderately consistent';
    } else if (moodVariability < 0.7) {
      return 'somewhat variable';
    } else {
      return 'highly variable';
    }
  }
}

/// Trend direction enum
enum TrendDirection {
  improving,
  declining,
  stable,
  volatile,
}

/// Individual mood data point for charting
class MoodDataPoint {
  final DateTime date;
  final double moodValue; // 0.0 to 1.0 (0 = worst, 1 = best)
  final String? moodLabel;

  MoodDataPoint({
    required this.date,
    required this.moodValue,
    this.moodLabel,
  });

  factory MoodDataPoint.fromMoodString(DateTime date, String mood) {
    final moodValues = {
      'terrible': 0.0,
      'bad': 0.25,
      'okay': 0.5,
      'good': 0.75,
      'great': 1.0,
    };

    return MoodDataPoint(
      date: date,
      moodValue: moodValues[mood.toLowerCase()] ?? 0.5,
      moodLabel: mood,
    );
  }
}
