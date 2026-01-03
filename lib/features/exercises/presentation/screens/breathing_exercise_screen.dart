import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/core/widgets/confetti_celebration.dart';
import 'package:freud_ai/features/exercises/presentation/widgets/breathing_exercise_card.dart';

class BreathingExerciseScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final BreathingPattern pattern;
  final Color accentColor;

  const BreathingExerciseScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.pattern,
    required this.accentColor,
  });

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  Timer? _exerciseTimer;
  int _currentCycle = 0;
  int _currentPhase = 0; // 0: inhale, 1: hold, 2: exhale, 3: hold after exhale
  int _phaseTimeRemaining = 0;
  bool _isPlaying = false;
  bool _isCompleted = false;

  final List<String> _phases = ['Inhale', 'Hold', 'Exhale', 'Hold'];
  final List<String> _instructions = [
    'Breathe in slowly through your nose',
    'Hold your breath comfortably',
    'Exhale slowly through your mouth',
    'Pause before the next breath'
  ];

  @override
  void initState() {
    super.initState();

    // Breathing animation controller
    _breathingController = AnimationController(
      duration: Duration(seconds: widget.pattern.inhaleDuration + widget.pattern.holdDuration +
          widget.pattern.exhaleDuration + widget.pattern.holdAfterExhaleDuration),
      vsync: this,
    );

    _breathingAnimation = Tween<double>(
      begin: 0.7,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOut,
    ));

    // Progress animation
    _progressController = AnimationController(
      duration: Duration(seconds: _calculateTotalDuration()),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_progressController);

    _resetExercise();
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _progressController.dispose();
    _exerciseTimer?.cancel();
    super.dispose();
  }

  int _calculateTotalDuration() {
    return widget.pattern.cycles *
        (widget.pattern.inhaleDuration +
         widget.pattern.holdDuration +
         widget.pattern.exhaleDuration +
         widget.pattern.holdAfterExhaleDuration);
  }

  void _resetExercise() {
    setState(() {
      _currentCycle = 0;
      _currentPhase = 0;
      _phaseTimeRemaining = widget.pattern.inhaleDuration;
      _isPlaying = false;
      _isCompleted = false;
    });
    _breathingController.reset();
    _progressController.reset();
  }

  void _startExercise() {
    setState(() => _isPlaying = true);
    _progressController.forward();
    _startBreathingCycle();
  }

  void _pauseExercise() {
    setState(() => _isPlaying = false);
    _breathingController.stop();
    _progressController.stop();
    _exerciseTimer?.cancel();
  }

  void _startBreathingCycle() {
    if (_currentCycle >= widget.pattern.cycles) {
      _completeExercise();
      return;
    }

    _breathingController.forward(from: 0.0);
    _startPhaseTimer();
  }

  void _startPhaseTimer() {
    final phaseDurations = [
      widget.pattern.inhaleDuration,
      widget.pattern.holdDuration,
      widget.pattern.exhaleDuration,
      widget.pattern.holdAfterExhaleDuration,
    ];

    setState(() {
      _phaseTimeRemaining = phaseDurations[_currentPhase];
    });

    _exerciseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        _phaseTimeRemaining--;
      });

      if (_phaseTimeRemaining <= 0) {
        timer.cancel();
        _nextPhase();
      }
    });
  }

  void _nextPhase() {
    setState(() {
      _currentPhase++;
      if (_currentPhase >= 4) {
        _currentPhase = 0;
        _currentCycle++;
      }
    });

    if (_currentCycle < widget.pattern.cycles) {
      _startPhaseTimer();
    } else {
      _completeExercise();
    }
  }

  void _completeExercise() {
    setState(() {
      _isPlaying = false;
      _isCompleted = true;
    });
    _breathingController.stop();
    _progressController.stop();
    _exerciseTimer?.cancel();

    // Show completion dialog
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    // Show confetti celebration first
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfettiCelebration(
        backgroundColor: widget.accentColor,
        iconColor: Colors.white,
        onComplete: () {
          Navigator.pop(context); // Close confetti overlay
          _showFinalCompletionDialog(); // Show final dialog
        },
      ),
    );
  }

  void _showFinalCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: widget.accentColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Great job!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4B3425),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You completed ${widget.pattern.cycles} breathing cycles',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF7A6F5C),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _resetExercise();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: widget.accentColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(color: widget.accentColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.accentColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${_currentCycle}/${widget.pattern.cycles}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        borderRadius: BorderRadius.circular(4),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Breathing circle
            AnimatedBuilder(
              animation: _breathingAnimation,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 120 * (_breathingAnimation.value),
                      height: 120 * (_breathingAnimation.value),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _phaseTimeRemaining.toString(),
                          style: TextStyle(
                            color: widget.accentColor,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ).animate(effects: [AnimationUtils.scaleIn()]);
              },
            ),

            const SizedBox(height: 40),

            // Current phase instruction
            AnimatedSwitcher(
              duration: AnimationUtils.normal,
              child: Column(
                key: ValueKey(_currentPhase),
                children: [
                  Text(
                    _phases[_currentPhase],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _instructions[_currentPhase],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Control buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_isCompleted) ...[
                    // Reset button
                    IconButton(
                      onPressed: _resetExercise,
                      icon: const Icon(Icons.replay, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    const SizedBox(width: 24),

                    // Play/Pause button
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _isPlaying ? _pauseExercise : _startExercise,
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: widget.accentColor,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
