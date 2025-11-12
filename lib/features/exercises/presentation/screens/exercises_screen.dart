import 'package:flutter/material.dart';
import 'package:freud_ai/features/exercises/presentation/widgets/breathing_exercise_card.dart';
import 'package:freud_ai/features/exercises/presentation/widgets/relaxation_exercise_card.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Breathing Exercises Section
          Text(
            'Breathing Exercises',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ),
          const SizedBox(height: 16),

          // Box Breathing
          BreathingExerciseCard(
            title: 'Box Breathing',
            subtitle: 'For anxiety & stress relief',
            description: 'A simple technique to calm your nervous system',
            icon: Icons.crop_square,
            color: const Color(0xFF9BB068),
            pattern: const BreathingPattern(
              inhaleDuration: 4,
              holdDuration: 4,
              exhaleDuration: 4,
              holdAfterExhaleDuration: 4,
              cycles: 4,
            ),
          ),
          const SizedBox(height: 12),

          // 4-7-8 Breathing
          BreathingExerciseCard(
            title: '4-7-8 Breathing',
            subtitle: 'For sleep & relaxation',
            description: 'Promotes better sleep and reduces anxiety',
            icon: Icons.nightlight,
            color: const Color(0xFFA18EFF),
            pattern: const BreathingPattern(
              inhaleDuration: 4,
              holdDuration: 7,
              exhaleDuration: 8,
              holdAfterExhaleDuration: 0,
              cycles: 4,
            ),
          ),
          const SizedBox(height: 32),

          // Relaxation Exercises Section
          Text(
            'Relaxation Exercises',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ),
          const SizedBox(height: 16),

          // Body Scan
          RelaxationExerciseCard(
            title: 'Body Scan Meditation',
            subtitle: 'Progressive muscle relaxation',
            description: 'Systematically tense and relax different muscle groups',
            icon: Icons.accessibility,
            color: const Color(0xFFFE804B),
            duration: 10, // minutes
            instructions: [
              'Lie down or sit comfortably',
              'Start from your toes, tense for 5 seconds, then release',
              'Move up through your body: feet, legs, abdomen, chest, arms, neck, face',
              'Notice the contrast between tension and relaxation',
              'Take deep breaths throughout the exercise',
            ],
          ),
          const SizedBox(height: 12),

          // Guided Relaxation
          RelaxationExerciseCard(
            title: 'Guided Relaxation',
            subtitle: 'Mindful body awareness',
            description: 'Follow along with calming visualizations',
            icon: Icons.spa,
            color: const Color(0xFFFFCE5B),
            duration: 15, // minutes
            instructions: [
              'Find a quiet, comfortable place to sit or lie down',
              'Close your eyes and take a few deep breaths',
              'Focus on relaxing each part of your body',
              'Imagine a peaceful scene or follow the guided imagery',
              'Let go of any tension or stress with each exhale',
            ],
          ),
          const SizedBox(height: 12),

          // Progressive Muscle Relaxation
          RelaxationExerciseCard(
            title: 'Progressive Relaxation',
            subtitle: 'Tension release technique',
            description: 'Learn to recognize and release muscle tension',
            icon: Icons.self_improvement,
            color: const Color(0xFFBDA193),
            duration: 20, // minutes
            instructions: [
              'Start in a comfortable position',
              'Begin with your feet and toes',
              'Tense each muscle group for 5-10 seconds',
              'Release and notice the sensation of relaxation',
              'Move systematically up through your body',
              'End with deep breathing and positive affirmations',
            ],
          ),
        ],
      ),
    );
  }
}
