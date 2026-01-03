import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

/// Full-screen confetti celebration overlay for exercise completion
/// Similar to ending_screen.dart but with flowing confetti from multiple directions
class ConfettiCelebration extends StatefulWidget {
  final VoidCallback? onComplete;
  final Color? backgroundColor;
  final List<Color>? confettiColors;
  final Color? iconColor;

  const ConfettiCelebration({
    super.key,
    this.onComplete,
    this.backgroundColor,
    this.confettiColors,
    this.iconColor,
  });

  @override
  State<ConfettiCelebration> createState() => _ConfettiCelebrationState();
}

class _ConfettiCelebrationState extends State<ConfettiCelebration> {
  late ConfettiController _topController;
  late ConfettiController _topLeftController;
  late ConfettiController _topRightController;
  late ConfettiController _leftController;
  late ConfettiController _rightController;
  late ConfettiController _bottomLeftController;
  late ConfettiController _bottomRightController;

  @override
  void initState() {
    super.initState();

    // Initialize all confetti controllers
    _topController = ConfettiController(duration: const Duration(seconds: 4));
    _topLeftController = ConfettiController(duration: const Duration(seconds: 4));
    _topRightController = ConfettiController(duration: const Duration(seconds: 4));
    _leftController = ConfettiController(duration: const Duration(seconds: 4));
    _rightController = ConfettiController(duration: const Duration(seconds: 4));
    _bottomLeftController = ConfettiController(duration: const Duration(seconds: 4));
    _bottomRightController = ConfettiController(duration: const Duration(seconds: 4));

    // Start all celebrations with slight delays for natural flow
    _topController.play();
    Future.delayed(const Duration(milliseconds: 200), () {
      _topLeftController.play();
      _topRightController.play();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _leftController.play();
      _rightController.play();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _bottomLeftController.play();
      _bottomRightController.play();
    });

    // Auto-dismiss after animation
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _topController.dispose();
    _topLeftController.dispose();
    _topRightController.dispose();
    _leftController.dispose();
    _rightController.dispose();
    _bottomLeftController.dispose();
    _bottomRightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme colors
    final defaultColors = [
      const Color(0xFFFE804B), // Orange
      const Color(0xFFA18EFF), // Purple
      const Color(0xFFFFCE5B), // Yellow
      const Color(0xFFED7E1C), // Dark orange
      const Color(0xFF9BB068), // Green
      Colors.white,
      Colors.pink,
      Colors.blue,
      Colors.cyan,
    ];

    final bgColor = widget.backgroundColor ?? const Color(0xFF9BB068);
    final confColors = widget.confettiColors ?? defaultColors;
    final icColor = widget.iconColor ?? bgColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Top center confetti - dropping straight down
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _topController,
              blastDirection: pi / 2, // Straight down
              emissionFrequency: 0.08,
              numberOfParticles: 15,
              maxBlastForce: 25,
              minBlastForce: 15,
              gravity: 0.15,
              colors: confColors,
            ),
          ),

          // Top left confetti - angled down and right
          Align(
            alignment: Alignment.topLeft,
            child: ConfettiWidget(
              confettiController: _topLeftController,
              blastDirection: pi / 3, // Angled down-right
              emissionFrequency: 0.06,
              numberOfParticles: 12,
              maxBlastForce: 20,
              minBlastForce: 12,
              gravity: 0.12,
              colors: confColors,
            ),
          ),

          // Top right confetti - angled down and left
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
              confettiController: _topRightController,
              blastDirection: 2 * pi / 3, // Angled down-left
              emissionFrequency: 0.06,
              numberOfParticles: 12,
              maxBlastForce: 20,
              minBlastForce: 12,
              gravity: 0.12,
              colors: confColors,
            ),
          ),

          // Left side confetti - flowing right and down
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _leftController,
              blastDirection: pi / 4, // Angled right-down
              emissionFrequency: 0.07,
              numberOfParticles: 10,
              maxBlastForce: 18,
              minBlastForce: 10,
              gravity: 0.1,
              colors: confColors,
            ),
          ),

          // Right side confetti - flowing left and down
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _rightController,
              blastDirection: 3 * pi / 4, // Angled left-down
              emissionFrequency: 0.07,
              numberOfParticles: 10,
              maxBlastForce: 18,
              minBlastForce: 10,
              gravity: 0.1,
              colors: confColors,
            ),
          ),

          // Bottom left confetti - flowing up and right
          Align(
            alignment: Alignment.bottomLeft,
            child: ConfettiWidget(
              confettiController: _bottomLeftController,
              blastDirection: -pi / 4, // Angled up-right
              emissionFrequency: 0.05,
              numberOfParticles: 8,
              maxBlastForce: 15,
              minBlastForce: 8,
              gravity: 0.08,
              colors: confColors,
            ),
          ),

          // Bottom right confetti - flowing up and left
          Align(
            alignment: Alignment.bottomRight,
            child: ConfettiWidget(
              confettiController: _bottomRightController,
              blastDirection: -3 * pi / 4, // Angled up-left
              emissionFrequency: 0.05,
              numberOfParticles: 8,
              maxBlastForce: 15,
              minBlastForce: 8,
              gravity: 0.08,
              colors: confColors,
            ),
          ),

          // Center celebration content - similar to ending screen
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Celebration icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.celebration,
                        color: icColor,
                        size: 60,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Celebration text
                    const Text(
                      '🎉 CONGRATULATIONS! 🎉',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'You completed your exercise successfully!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Keep up the great work! 🌟',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
