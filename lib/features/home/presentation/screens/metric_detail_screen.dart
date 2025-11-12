import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

class MetricDetailScreen extends StatefulWidget {
  final String metricType;
  final String title;
  final Color accentColor;
  final String currentValue;
  final String status;
  final String message;

  const MetricDetailScreen({
    super.key,
    required this.metricType,
    required this.title,
    required this.accentColor,
    required this.currentValue,
    required this.status,
    required this.message,
  });

  @override
  State<MetricDetailScreen> createState() => _MetricDetailScreenState();
}

class _MetricDetailScreenState extends State<MetricDetailScreen> {
  // Sample history data - in real app this would come from database
  final List<Map<String, dynamic>> _historyData = [
    {
      'date': 'Sep 12',
      'mood': 'Anxious, Depressed',
      'recommendation': 'Please do 25m Mindfulness.',
      'score': 65,
      'color': Colors.red,
    },
    {
      'date': 'Sep 11',
      'mood': 'Very Happy',
      'recommendation': 'No Recommendation.',
      'score': 95,
      'color': const Color(0xFF9BB068),
    },
    {
      'date': 'Sep 11',
      'mood': 'Very Happy',
      'recommendation': 'Keep it Up!',
      'score': 85,
      'color': const Color(0xFF9BB068),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.accentColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(
                          _getMetricIcon(widget.metricType),
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCFD8B5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            widget.status.toUpperCase(),
                            style: TextStyle(
                              color: widget.accentColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: AnimationUtils.normal),

              // Large score display
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      widget.currentValue,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 128,
                        fontWeight: FontWeight.w800,
                        height: 1,
                        letterSpacing: -5.12,
                      ),
                    ).animate(effects: [AnimationUtils.scaleIn(delay: const Duration(milliseconds: 200), duration: AnimationUtils.slow)]),

                    const SizedBox(height: 16),

                    Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.20,
                      ),
                    ).animate().fadeIn(delay: const Duration(milliseconds: 400), duration: AnimationUtils.normal),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Floating action button for insights
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4B3425),
                        borderRadius: BorderRadius.circular(1000),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x194B3425),
                            blurRadius: 0,
                            offset: const Offset(0, 0),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: const Color(0x194B3425),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: const Color(0x164B3425),
                            blurRadius: 9,
                            offset: const Offset(0, 9),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: const Color(0x0C4B3425),
                            blurRadius: 12,
                            offset: const Offset(0, 20),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: const Color(0x024B3425),
                            blurRadius: 14,
                            offset: const Offset(0, 35),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: const Color(0x004B3425),
                            blurRadius: 15,
                            offset: const Offset(0, 55),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.insights, color: Colors.white),
                      ),
                    ).animate(effects: [AnimationUtils.scaleIn(delay: const Duration(milliseconds: 600), duration: AnimationUtils.normal)]),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // White content area
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    // Mental Score History header
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.title} History',
                            style: const TextStyle(
                              color: Color(0xFF4B3425),
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert, color: Color(0xFF4B3425)),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: const Duration(milliseconds: 800), duration: AnimationUtils.normal),

                    // History items
                    ..._historyData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return _buildHistoryItem(item, index);
                    }),

                    const SizedBox(height: 24),

                    // Insights section
                    _buildInsightsSection(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3F2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // Date and score
          Container(
            width: 48,
            height: 64,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['date'].split(' ')[1], // Day
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0x7A1F160F),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.20,
                  ),
                ),
                Text(
                  item['date'].split(' ')[0], // Month
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF4B3425),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.20,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Mood and recommendation
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['mood'],
                  style: const TextStyle(
                    color: Color(0xFF4B3425),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['recommendation'],
                  style: const TextStyle(
                    color: Color(0xA31F160F),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.14,
                  ),
                ),
              ],
            ),
          ),

          // Score circle
          Container(
            width: 64,
            height: 64,
            child: Stack(
              children: [
                Positioned(
                  left: 25,
                  top: 25,
                  child: Text(
                    item['score'].toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF4B3425),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.12,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 10,
                          color: const Color(0xFFE7DDD8),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 10,
                          color: item['color'],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animateStaggered(index, baseDelay: const Duration(milliseconds: 1000));
  }

  Widget _buildInsightsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0C4B3425),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4EA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.insights, color: Color(0xFF9BB068)),
                  ),
                  const SizedBox(width: 13),
                  const Text(
                    'Recommendations',
                    style: TextStyle(
                      color: Color(0xFF4B3425),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.16,
                    ),
                  ),
                ],
              ),
              Text(
                '78+',
                style: const TextStyle(
                  color: Color(0xA31F160F),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Placeholder for recommendations content
          const Text(
            'Based on your recent scores, here are some personalized recommendations to improve your mental wellness.',
            style: TextStyle(
              color: Color(0xA31F160F),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.60,
              letterSpacing: -0.14,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: const Duration(milliseconds: 1400), duration: AnimationUtils.normal);
  }

  IconData _getMetricIcon(String metricType) {
    switch (metricType) {
      case 'freud_score':
        return Icons.psychology;
      case 'mood':
        return Icons.sentiment_satisfied_alt;
      case 'journal':
        return Icons.book;
      case 'sleep':
        return Icons.nightlight_round;
      case 'stress':
        return Icons.warning;
      case 'mindfulness':
        return Icons.self_improvement;
      default:
        return Icons.analytics;
    }
  }
}
