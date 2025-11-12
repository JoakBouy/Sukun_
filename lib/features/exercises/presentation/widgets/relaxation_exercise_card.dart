import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';

class RelaxationExerciseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final int duration; // in minutes
  final List<String> instructions;

  const RelaxationExerciseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.duration,
    required this.instructions,
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

            // Instructions preview (show first 2-3)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4B3425),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...instructions.take(3).map((instruction) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF7A6F5C),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            instruction,
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF7A6F5C),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  if (instructions.length > 3)
                    Text(
                      '...and ${instructions.length - 3} more steps',
                      style: TextStyle(
                        fontSize: 10,
                        color: const Color(0xFF7A6F5C),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Duration info
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: const Color(0xFF7A6F5C),
                ),
                const SizedBox(width: 8),
                Text(
                  '$duration minutes',
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

  void _navigateToExercise(BuildContext context) {
    Navigator.pushNamed(
      context,
      NavigationManager.relaxationExerciseScreen,
      arguments: {
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'accentColor': color,
        'duration': duration,
        'instructions': instructions,
      },
    );
  }
}
