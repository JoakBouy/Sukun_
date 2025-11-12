import 'package:flutter/material.dart';

/// Enhanced mindful hours card with progress tracking
/// Based on reference design with detailed session information
class MindfulHoursCard extends StatelessWidget {
  final String sessionName;
  final String category;
  final double progress; // 0.0 to 1.0
  final String currentTime;
  final String totalTime;
  final Color progressColor;

  const MindfulHoursCard({
    super.key,
    required this.sessionName,
    required this.category,
    required this.progress,
    required this.currentTime,
    required this.totalTime,
    this.progressColor = const Color(0xFF9BB068),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        spacing: 10,
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 26,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Text(
                          sessionName,
                          style: const TextStyle(
                            color: Color(0xFF4B3425),
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF7F3F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                category,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF926247),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Container(
                          width: 232,
                          height: 6,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE5EAD6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1234),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 232 * progress,
                                  height: 6,
                                  decoration: ShapeDecoration(
                                    color: progressColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1234),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 230,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 169,
                            children: [
                              Text(
                                currentTime,
                                style: const TextStyle(
                                  color: Color(0x7A1F160F),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.12,
                                ),
                              ),
                              Text(
                                totalTime,
                                style: const TextStyle(
                                  color: Color(0x7A1F160F),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F3F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Color(0xFF4B3425),
                        size: 24,
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
