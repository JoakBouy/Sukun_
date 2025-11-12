import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';

class BreathingExerciseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final BreathingPattern pattern;

  const BreathingExerciseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToExercise(context),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4B3425),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF7A6F5C),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 16,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF4B3425),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 16),

            // Breathing pattern preview
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPhaseIndicator('Inhale', pattern.inhaleDuration, color),
                  _buildPhaseIndicator('Hold', pattern.holdDuration, color),
                  _buildPhaseIndicator('Exhale', pattern.exhaleDuration, color),
                  if (pattern.holdAfterExhaleDuration > 0)
                    _buildPhaseIndicator('Hold', pattern.holdAfterExhaleDuration, color),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Duration and cycles info
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: const Color(0xFF7A6F5C),
                ),
                const SizedBox(width: 8),
                Text(
                  '~${_calculateDuration()} min • ${pattern.cycles} cycles',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF7A6F5C),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator(String label, int duration, Color color) {
    return Column(
      children: [
        Text(
          '$duration',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: const Color(0xFF7A6F5C),
          ),
        ),
      ],
    );
  }

  int _calculateDuration() {
    final totalSeconds = pattern.cycles *
        (pattern.inhaleDuration +
         pattern.holdDuration +
         pattern.exhaleDuration +
         pattern.holdAfterExhaleDuration);
    return (totalSeconds / 60).ceil();
  }

  void _navigateToExercise(BuildContext context) {
    Navigator.pushNamed(
      context,
      NavigationManager.breathingExerciseScreen,
      arguments: {
        'title': title,
        'subtitle': subtitle,
        'pattern': pattern,
        'accentColor': color,
      },
    );
  }
}

class BreathingPattern {
  final int inhaleDuration;
  final int holdDuration;
  final int exhaleDuration;
  final int holdAfterExhaleDuration;
  final int cycles;

  const BreathingPattern({
    required this.inhaleDuration,
    required this.holdDuration,
    required this.exhaleDuration,
    required this.holdAfterExhaleDuration,
    required this.cycles,
  });
}
