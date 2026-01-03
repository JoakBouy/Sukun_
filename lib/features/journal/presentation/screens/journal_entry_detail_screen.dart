import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/features/journal/presentation/widgets/journal_entry_card.dart';

class JournalEntryDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String mood;
  final Color moodColor;
  final String date;
  final JournalType type;

  const JournalEntryDetailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.mood,
    required this.moodColor,
    required this.date,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date & Mood Header
            Row(
              children: [
                Hero(
                  tag: 'mood_icon_$title',
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: moodColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      type == JournalType.voice ? Icons.mic : Icons.edit,
                      color: moodColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).extension<CustomColors>()!.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: moodColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'MOOD: ${mood.toUpperCase()}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: moodColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 32),

            // Title Hero
            Hero(
              tag: 'title_$title',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4B3425),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Content
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: const Color(0xFF7A6F5C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
