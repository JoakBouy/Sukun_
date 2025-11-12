import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

class MoodSelectorWidget extends StatefulWidget {
  const MoodSelectorWidget({super.key});

  @override
  State<MoodSelectorWidget> createState() => _MoodSelectorWidgetState();
}

class _MoodSelectorWidgetState extends State<MoodSelectorWidget> {
  String _selectedMood = 'neutral';
  bool _isMoodLoggedToday = false; // Track if mood has been logged today

  final Map<String, MoodData> _moods = {
    'overjoyed': MoodData(
      emoji: '🤩',
      label: 'Overjoyed',
      color: const Color(0xFF9BB068),
      backgroundColor: const Color(0xFFCFD8B5),
    ),
    'happy': MoodData(
      emoji: '😊',
      label: 'Happy',
      color: const Color(0xFFFFCE5B),
      backgroundColor: const Color(0xFFFFEAC1),
    ),
    'neutral': MoodData(
      emoji: '😐',
      label: 'Neutral',
      color: const Color(0xFFBDA193),
      backgroundColor: const Color(0xFFE5D4C9),
    ),
    'sad': MoodData(
      emoji: '😢',
      label: 'Sad',
      color: const Color(0xFFFE804B),
      backgroundColor: const Color(0xFFFEAE8F),
    ),
    'depressed': MoodData(
      emoji: '😔',
      label: 'Depressed',
      color: const Color(0xFFA18EFF),
      backgroundColor: const Color(0xFFCAC1FF),
    ),
  };

  void _selectMood(String moodKey) {
    setState(() {
      _selectedMood = moodKey;
    });
  }

  void _logMood() {
    // In a real app, this would save to database
    setState(() {
      _isMoodLoggedToday = true;
    });
    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mood logged successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedMoodData = _moods[_selectedMood]!;
    final ThemeData theme = Theme.of(context);

    // If mood is already logged today, show logged state
    if (_isMoodLoggedToday) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: selectedMoodData.backgroundColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Greeting
            Text(
              'Welcome Back, Buoy',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4B3425),
              ),
            ),
            const SizedBox(height: 16),

            // Mood logged confirmation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: selectedMoodData.backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: selectedMoodData.color.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      selectedMoodData.emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s log taken',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4B3425),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Feeling ${selectedMoodData.label.toLowerCase()}',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF7A6F5C),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: selectedMoodData.color,
                  size: 24,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Journal insights preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.insights,
                    color: selectedMoodData.color,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your mood patterns show improvement over the last week',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF4B3425),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Simplified mood selector - just a "Set Mood" button
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, NavigationManager.moodSelectorScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: selectedMoodData.backgroundColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Combined greeting and mood question
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back, Buoy',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4B3425),
                  ),
                ).animate().fadeIn(duration: AnimationUtils.normal),
                const SizedBox(height: 8),
                Text(
                  'How are you feeling today?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4B3425),
                  ),
                ).animate().fadeIn(delay: const Duration(milliseconds: 200), duration: AnimationUtils.normal),
              ],
            ),
            const SizedBox(height: 24),

            // Set Mood button with tap animation
            AnimatedContainer(
              duration: AnimationUtils.fast,
              curve: Curves.easeInOut,
              width: double.infinity,
              height: 48,
              decoration: ShapeDecoration(
                color: selectedMoodData.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                shadows: [
                  BoxShadow(
                    color: selectedMoodData.color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Set Mood',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ).animateCardTap().animate().fadeIn(delay: const Duration(milliseconds: 400), duration: AnimationUtils.normal),
          ],
        ),
      ),
    ).animate().fadeIn(duration: AnimationUtils.normal);
  }
}

class MoodData {
  final String emoji;
  final String label;
  final Color color;
  final Color backgroundColor;

  const MoodData({
    required this.emoji,
    required this.label,
    required this.color,
    required this.backgroundColor,
  });
}
