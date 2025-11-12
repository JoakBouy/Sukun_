import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/core/widgets/confetti_celebration.dart';

class RelaxationExerciseScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final Color accentColor;
  final int duration; // in minutes
  final List<String> instructions;

  const RelaxationExerciseScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.accentColor,
    required this.duration,
    required this.instructions,
  });

  @override
  State<RelaxationExerciseScreen> createState() => _RelaxationExerciseScreenState();
}

class _RelaxationExerciseScreenState extends State<RelaxationExerciseScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  Timer? _exerciseTimer;
  int _currentStep = 0;
  int _timeRemaining = 0; // in seconds
  bool _isPlaying = false;
  bool _isCompleted = false;

  int get _totalDuration => widget.duration * 60; // convert to seconds

  @override
  void initState() {
    super.initState();

    // Progress animation
    _progressController = AnimationController(
      duration: Duration(seconds: _totalDuration),
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
    _progressController.dispose();
    _exerciseTimer?.cancel();
    super.dispose();
  }

  void _resetExercise() {
    setState(() {
      _currentStep = 0;
      _timeRemaining = _totalDuration;
      _isPlaying = false;
      _isCompleted = false;
    });
    _progressController.reset();
  }

  void _startExercise() {
    setState(() => _isPlaying = true);
    _progressController.forward();
    _startStepTimer();
  }

  void _pauseExercise() {
    setState(() => _isPlaying = false);
    _progressController.stop();
    _exerciseTimer?.cancel();
  }

  void _startStepTimer() {
    const stepDuration = 30; // 30 seconds per step (adjustable)
    final steps = widget.instructions.length;
    final timePerStep = _totalDuration ~/ steps;

    setState(() {
      _timeRemaining = timePerStep;
    });

    _exerciseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        _timeRemaining--;
      });

      if (_timeRemaining <= 0) {
        if (_currentStep < widget.instructions.length - 1) {
          setState(() {
            _currentStep++;
            _timeRemaining = timePerStep;
          });
        } else {
          _completeExercise();
        }
      }
    });
  }

  void _nextStep() {
    if (_currentStep < widget.instructions.length - 1) {
      setState(() {
        _currentStep++;
        _timeRemaining = _totalDuration ~/ widget.instructions.length;
      });
    } else {
      _completeExercise();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _timeRemaining = _totalDuration ~/ widget.instructions.length;
      });
    }
  }

  void _completeExercise() {
    setState(() {
      _isPlaying = false;
      _isCompleted = true;
    });
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
              'Well done!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4B3425),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You completed the ${widget.title}',
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

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
                        _formatTime(_timeRemaining),
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

            // Step indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.instructions.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index == _currentStep ? Colors.white : Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Current instruction
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: AnimatedSwitcher(
                duration: AnimationUtils.normal,
                child: Column(
                  key: ValueKey(_currentStep),
                  children: [
                    Text(
                      'Step ${_currentStep + 1} of ${widget.instructions.length}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.instructions[_currentStep],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Navigation buttons
            if (!_isCompleted)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _currentStep > 0 ? _previousStep : null,
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: _currentStep > 0
                            ? Colors.white.withOpacity(0.2)
                            : Colors.white.withOpacity(0.1),
                      ),
                    ),
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
                    IconButton(
                      onPressed: _nextStep,
                      icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
