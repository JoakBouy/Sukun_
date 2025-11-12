import 'package:flutter/material.dart';

/// Enhanced sleep quality card with detailed stats
/// Based on reference design with sleep level indicators
class SleepQualityCard extends StatelessWidget {
  final int sleepLevel;
  final String sleepStatus;
  final String lastSleepTime;
  final String startSleepTime;
  final String wakeUpTime;
  final String deepSleepTime;
  final String totalSleepDuration;

  const SleepQualityCard({
    super.key,
    required this.sleepLevel,
    required this.sleepStatus,
    required this.lastSleepTime,
    required this.startSleepTime,
    required this.wakeUpTime,
    required this.deepSleepTime,
    required this.totalSleepDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            width: 343,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 131,
              children: [
                const Text(
                  'Sleep Stats',
                  style: TextStyle(
                    color: Color(0xFF4B3425),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.18,
                  ),
                ),
                Container(width: 24, height: 24, child: Stack()),
              ],
            ),
          ),
          // Sleep level indicator
          Container(
            width: 343,
            height: 120,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 343,
                    height: 120,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFA18EFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        'Level $sleepLevel',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.72,
                        ),
                      ),
                      Text(
                        'You are $sleepStatus.',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.16,
                        ),
                      ),
                      // Progress indicators
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: List.generate(
                          5,
                          (index) => Container(
                            width: 8,
                            height: 8,
                            decoration: ShapeDecoration(
                              color: index < sleepLevel ? Colors.white : Colors.white.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1234),
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
          ),
          // Sleep stats cards
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatCard(
                icon: Icons.bedtime,
                title: 'Last Sleep',
                value: lastSleepTime,
              ),
              _buildStatCard(
                icon: Icons.nightlight,
                title: 'Start Sleeping',
                value: startSleepTime,
              ),
              _buildStatCard(
                icon: Icons.wb_sunny,
                title: 'Wake Up',
                value: wakeUpTime,
              ),
              _buildStatCard(
                icon: Icons.dark_mode,
                title: 'Deep Sleep',
                value: deepSleepTime,
              ),
            ],
          ),
          // Sleep duration badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFFE7DDD8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1234),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xFF926247),
                  size: 16,
                ),
                Text(
                  'Total Sleep: $totalSleepDuration',
                  style: const TextStyle(
                    color: Color(0xFF926247),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: 164,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x0C4B3425),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F3F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(
                        icon,
                        color: const Color(0xFF4B3425),
                        size: 24,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF4B3425),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.16,
                        ),
                      ),
                      Text(
                        value,
                        style: const TextStyle(
                          color: Color(0xFF4B3425),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
