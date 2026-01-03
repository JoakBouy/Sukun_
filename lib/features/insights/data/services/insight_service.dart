import 'package:flutter/foundation.dart';
import 'package:freud_ai/core/data/local/database_helper.dart';
import 'package:freud_ai/features/insights/data/models/mood_insight.dart';
import 'dart:math';

/// Service to analyze mood data and generate personalized insights
class InsightService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Analyze mood trends over the specified number of days
  Future<MoodInsight> analyzeMoodTrends({int days = 7}) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: days));

    if (kIsWeb) {
      return _getDefaultInsight(startDate, endDate);
    }

    // Get mood logs from database
    final moodLogs = await _dbHelper.getMoodLogsInRange(
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
    );

    if (moodLogs.isEmpty) {
      return _getDefaultInsight(startDate, endDate);
    }

    // Convert to data points
    final dataPoints = moodLogs.map((log) {
      return MoodDataPoint.fromMoodString(
        DateTime.fromMillisecondsSinceEpoch(log['created_at'] as int),
        log['mood'] as String,
      );
    }).toList();

    // Calculate metrics
    final averageMood = _calculateAverage(dataPoints);
    final moodVariability = _calculateVariability(dataPoints);
    final trendDirection = _determineTrend(dataPoints);
    final recommendations = _generateRecommendations(
      averageMood,
      moodVariability,
      trendDirection,
    );
    final summary = _generateSummary(
      averageMood,
      moodVariability,
      trendDirection,
      days,
    );

    return MoodInsight(
      trendDirection: trendDirection,
      averageMood: averageMood,
      moodVariability: moodVariability,
      recommendations: recommendations,
      summary: summary,
      dataPoints: dataPoints,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Get weekly summary
  Future<String> getWeeklySummary() async {
    final insight = await analyzeMoodTrends(days: 7);
    return insight.summary;
  }

  /// Calculate average mood value
  double _calculateAverage(List<MoodDataPoint> dataPoints) {
    if (dataPoints.isEmpty) return 0.5;
    
    final sum = dataPoints.fold<double>(
      0.0,
      (sum, point) => sum + point.moodValue,
    );
    return sum / dataPoints.length;
  }

  /// Calculate mood variability (standard deviation)
  double _calculateVariability(List<MoodDataPoint> dataPoints) {
    if (dataPoints.length < 2) return 0.0;

    final average = _calculateAverage(dataPoints);
    final squaredDiffs = dataPoints.map((point) {
      final diff = point.moodValue - average;
      return diff * diff;
    });

    final variance = squaredDiffs.reduce((a, b) => a + b) / dataPoints.length;
    return sqrt(variance);
  }

  /// Determine trend direction
  TrendDirection _determineTrend(List<MoodDataPoint> dataPoints) {
    if (dataPoints.length < 3) return TrendDirection.stable;

    // Calculate linear regression slope
    final n = dataPoints.length;
    double sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0;

    for (var i = 0; i < n; i++) {
      final x = i.toDouble();
      final y = dataPoints[i].moodValue;
      sumX += x;
      sumY += y;
      sumXY += x * y;
      sumX2 += x * x;
    }

    final slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    final variability = _calculateVariability(dataPoints);

    // Determine trend based on slope and variability
    if (variability > 0.4) {
      return TrendDirection.volatile;
    } else if (slope > 0.02) {
      return TrendDirection.improving;
    } else if (slope < -0.02) {
      return TrendDirection.declining;
    } else {
      return TrendDirection.stable;
    }
  }

  /// Generate personalized recommendations
  List<String> _generateRecommendations(
    double averageMood,
    double variability,
    TrendDirection trend,
  ) {
    final recommendations = <String>[];

    // Recommendations based on trend
    switch (trend) {
      case TrendDirection.improving:
        recommendations.add('Keep up the great work! Continue your current routines.');
        recommendations.add('Consider journaling about what\'s been helping you.');
        break;
      case TrendDirection.declining:
        recommendations.add('Consider reaching out to a therapist for support.');
        recommendations.add('Try incorporating relaxation exercises into your daily routine.');
        break;
      case TrendDirection.stable:
        if (averageMood > 0.6) {
          recommendations.add('You\'re maintaining a positive mood. Keep it up!');
        } else {
          recommendations.add('Consider trying new coping strategies to improve your mood.');
        }
        break;
      case TrendDirection.volatile:
        recommendations.add('Your mood has been fluctuating. Try to identify triggers.');
        recommendations.add('Consistent sleep and exercise can help stabilize mood.');
        break;
    }

    // Recommendations based on average mood
    if (averageMood < 0.4) {
      recommendations.add('Consider professional support if you\'re struggling.');
      recommendations.add('Practice self-compassion and be gentle with yourself.');
    } else if (averageMood > 0.7) {
      recommendations.add('Share your positive strategies with others who might benefit.');
    }

    // Recommendations based on variability
    if (variability > 0.5) {
      recommendations.add('Track your activities to identify mood patterns.');
      recommendations.add('Mindfulness meditation can help with emotional regulation.');
    }

    return recommendations.take(3).toList(); // Return top 3 recommendations
  }

  /// Generate summary text
  String _generateSummary(
    double averageMood,
    double variability,
    TrendDirection trend,
    int days,
  ) {
    final moodDescription = averageMood > 0.7
        ? 'positive'
        : averageMood > 0.5
            ? 'moderate'
            : 'challenging';

    return 'Over the past $days days, your mood has been $moodDescription and ${trend.name}. '
        'Your emotional state has been ${variability < 0.4 ? 'consistent' : 'variable'}.';
  }

  /// Get default insight when no data available
  MoodInsight _getDefaultInsight(DateTime startDate, DateTime endDate) {
    return MoodInsight(
      trendDirection: TrendDirection.stable,
      averageMood: 0.5,
      moodVariability: 0.0,
      recommendations: [
        'Start tracking your mood daily to get personalized insights.',
        'Journal regularly to understand your emotional patterns.',
        'Consider booking a session with a therapist.',
      ],
      summary: 'Not enough data yet. Start tracking your mood to see insights.',
      dataPoints: [],
      startDate: startDate,
      endDate: endDate,
    );
  }
}
