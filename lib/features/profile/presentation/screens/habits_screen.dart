import 'package:flutter/material.dart';
import 'package:freud_ai/features/profile/presentation/widgets/habit_tracker_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits & Goals'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF4B3425),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Header Section
          Text(
            'Track Your Progress',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 8),
          Text(
            'Build healthy habits and achieve your mental wellness goals',
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF7A6F5C),
              height: 1.5,
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
          const SizedBox(height: 32),

          // Current Habits Section
          Text(
            'Current Habits',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
          const SizedBox(height: 16),

          // Daily Journaling Habit
          HabitTrackerCard(
            title: 'Daily Journaling',
            subtitle: '34/365 days completed',
            progress: 0.094, // 34/365
            color: const Color(0xFF9BB068),
            streak: 7,
            icon: Icons.book,
            onTap: () => _showHabitDetails(context, 'Daily Journaling'),
          ).animate().fadeIn(duration: 600.ms, delay: 300.ms),

          const SizedBox(height: 16),

          // Weekly Exercises Habit
          HabitTrackerCard(
            title: 'Weekly Exercises',
            subtitle: '3/4 sessions this week',
            progress: 0.75,
            color: const Color(0xFFA18EFF),
            streak: 3,
            icon: Icons.fitness_center,
            onTap: () => _showHabitDetails(context, 'Weekly Exercises'),
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

          const SizedBox(height: 16),

          // Mood Tracking Habit
          HabitTrackerCard(
            title: 'Mood Tracking',
            subtitle: '12/31 days this month',
            progress: 0.387,
            color: const Color(0xFFFFCE5B),
            streak: 12,
            icon: Icons.sentiment_satisfied,
            onTap: () => _showHabitDetails(context, 'Mood Tracking'),
          ).animate().fadeIn(duration: 600.ms, delay: 500.ms),

          const SizedBox(height: 32),

          // Goals Section
          Text(
            'Personal Goals',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 600.ms),
          const SizedBox(height: 16),

          // Goal Cards
          _buildGoalCard(
            context,
            'Complete 100 Journal Entries',
            'Build self-reflection habits',
            0.34,
            const Color(0xFF9BB068),
            Icons.edit_note,
          ).animate().fadeIn(duration: 600.ms, delay: 700.ms),

          const SizedBox(height: 16),

          _buildGoalCard(
            context,
            '30-Day Mindfulness Streak',
            'Practice daily mindfulness',
            0.67,
            const Color(0xFFA18EFF),
            Icons.self_improvement,
          ).animate().fadeIn(duration: 600.ms, delay: 800.ms),

          const SizedBox(height: 16),

          _buildGoalCard(
            context,
            'Weekly Therapy Sessions',
            'Maintain consistent mental health support',
            0.8,
            const Color(0xFFFFCE5B),
            Icons.healing,
          ).animate().fadeIn(duration: 600.ms, delay: 900.ms),

          const SizedBox(height: 32),

          // Add New Habit Button
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF9BB068), Color(0xFFA18EFF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9BB068).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => _showAddHabitDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Create New Habit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context, String title, String subtitle,
      double progress, Color color, IconData icon) {
    return Container(
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
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4B3425),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFF7A6F5C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(progress * 100).round()}%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHabitDetails(BuildContext context, String habitName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habitName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4B3425),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Track your progress and build consistency with this habit.',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF7A6F5C),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Habit statistics would go here
                    Text(
                      'Habit Statistics',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4B3425),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Placeholder for statistics
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Detailed statistics coming soon!',
                          style: TextStyle(
                            color: Color(0xFF7A6F5C),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Habit'),
        content: const Text('Custom habit creation coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
