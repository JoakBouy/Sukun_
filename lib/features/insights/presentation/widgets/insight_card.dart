import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/insights/data/models/mood_insight.dart';

/// Widget to display personalized mood insights
class InsightCard extends StatelessWidget {
  final MoodInsight insight;
  final VoidCallback? onViewFullReport;

  const InsightCard({
    super.key,
    required this.insight,
    this.onViewFullReport,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: SizesManager.padding,
        vertical: SizesManager.hPadding,
      ),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(SizesManager.padding),
            child: Row(
              children: [
                Icon(
                  _getTrendIcon(),
                  color: _getTrendColor(colors),
                  size: 28,
                ),
                const SizedBox(width: SizesManager.vPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Mood Insights',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        insight.trendDescription,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: _getTrendColor(colors),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            color: colors.onPrimaryContainer.withOpacity(0.1),
            height: 1,
          ),

          // Summary
          Padding(
            padding: const EdgeInsets.all(SizesManager.padding),
            child: Text(
              insight.summary,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          // Mini trend chart
          if (insight.dataPoints.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizesManager.padding,
              ),
              child: _buildMiniChart(colors),
            ),

          // Recommendations
          if (insight.recommendations.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommendations',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: SizesManager.hPadding),
                  ...insight.recommendations.take(2).map((rec) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: SizesManager.hPadding,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              size: 16,
                              color: colors.primary,
                            ),
                            const SizedBox(width: SizesManager.hPadding),
                            Expanded(
                              child: Text(
                                rec,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),

          // View Full Report Button
          if (onViewFullReport != null)
            Padding(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onViewFullReport,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.primary),
                  ),
                  child: Text(
                    'View Full Report',
                    style: TextStyle(color: colors.primary),
                  ),
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(
          begin: 0.1,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }

  /// Build mini trend chart
  Widget _buildMiniChart(CustomColors colors) {
    return SizedBox(
      height: 60,
      child: CustomPaint(
        painter: _MiniChartPainter(
          dataPoints: insight.dataPoints,
          color: _getTrendColor(colors),
        ),
        child: Container(),
      ),
    );
  }

  /// Get icon based on trend
  IconData _getTrendIcon() {
    switch (insight.trendDirection) {
      case TrendDirection.improving:
        return Icons.trending_up;
      case TrendDirection.declining:
        return Icons.trending_down;
      case TrendDirection.stable:
        return Icons.trending_flat;
      case TrendDirection.volatile:
        return Icons.show_chart;
    }
  }

  /// Get color based on trend
  Color _getTrendColor(CustomColors colors) {
    switch (insight.trendDirection) {
      case TrendDirection.improving:
        return Colors.green;
      case TrendDirection.declining:
        return Colors.orange;
      case TrendDirection.stable:
        return colors.primary;
      case TrendDirection.volatile:
        return Colors.purple;
    }
  }
}

/// Custom painter for mini trend chart
class _MiniChartPainter extends CustomPainter {
  final List<MoodDataPoint> dataPoints;
  final Color color;

  _MiniChartPainter({
    required this.dataPoints,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    // Calculate points
    final points = <Offset>[];
    for (var i = 0; i < dataPoints.length; i++) {
      final x = (i / (dataPoints.length - 1)) * size.width;
      final y = size.height - (dataPoints[i].moodValue * size.height);
      points.add(Offset(x, y));
    }

    // Draw line
    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      fillPath.moveTo(points.first.dx, size.height);
      fillPath.lineTo(points.first.dx, points.first.dy);

      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
        fillPath.lineTo(points[i].dx, points[i].dy);
      }

      fillPath.lineTo(points.last.dx, size.height);
      fillPath.close();

      canvas.drawPath(fillPath, fillPaint);
      canvas.drawPath(path, paint);

      // Draw points
      final pointPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      for (final point in points) {
        canvas.drawCircle(point, 3, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
