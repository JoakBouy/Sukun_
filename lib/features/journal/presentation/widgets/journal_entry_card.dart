import 'package:flutter/material.dart';

enum JournalType { text, voice }

class JournalEntryCard extends StatelessWidget {
  final String title;
  final String preview;
  final String mood;
  final Color moodColor;
  final String date;
  final JournalType type;
  final VoidCallback onTap;

  const JournalEntryCard({
    super.key,
    required this.title,
    required this.preview,
    required this.mood,
    required this.moodColor,
    required this.date,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with type icon and date
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: moodColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    type == JournalType.voice ? Icons.mic : Icons.edit,
                    color: moodColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4B3425),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: moodColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'MOOD: ${mood.toUpperCase()}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: moodColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            date,
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
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFFD4C1B9),
                  size: 16,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Preview text
            Text(
              preview,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF7A6F5C),
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Type indicator
            Row(
              children: [
                Icon(
                  type == JournalType.voice ? Icons.mic : Icons.text_fields,
                  size: 14,
                  color: const Color(0xFF7A6F5C),
                ),
                const SizedBox(width: 4),
                Text(
                  type == JournalType.voice ? 'Voice Entry' : 'Text Entry',
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
}
