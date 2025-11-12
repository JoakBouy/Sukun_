import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class HabitTrackerCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final double progress;
  final Color color;
  final int streak;
  final IconData icon;
  final VoidCallback? onTap;

  const HabitTrackerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.color,
    required this.streak,
    required this.icon,
    this.onTap,
  });

  @override
  State<HabitTrackerCard> createState() => _HabitTrackerCardState();
}

class _HabitTrackerCardState extends State<HabitTrackerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late double _previousProgress;

  @override
  void initState() {
    super.initState();
    _previousProgress = widget.progress;

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _progressAnimation = Tween<double>(
      begin: _previousProgress,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
    ));

    _progressController.forward();
  }

  @override
  void didUpdateWidget(covariant HabitTrackerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress ||
        widget.streak != oldWidget.streak) {
      setState(() {
        _previousProgress = oldWidget.progress;
      });
      _progressController.reset();
      _progressAnimation = Tween<double>(
        begin: _previousProgress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _progressController,
        curve: Curves.elasticOut,
      ));
      _progressController.forward();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
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
              if (_glowAnimation.value > 0)
                BoxShadow(
                  color: widget.color.withOpacity(0.2 * _glowAnimation.value),
                  blurRadius: 20 * _glowAnimation.value,
                  offset: const Offset(0, 0),
                ),
            ],
          ),
          child: Column(
            children: [
              // Header with icon and title
              Row(
                children: [
                  // Animated icon with scale and glow
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.color.withOpacity(0.3 * _glowAnimation.value),
                                blurRadius: 12 * _glowAnimation.value,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.icon,
                            color: widget.color,
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ).animate()
                   .scale(duration: 500.ms, curve: Curves.elasticOut),

                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4B3425),
                          ),
                        ).animate()
                         .fadeIn(duration: 400.ms)
                         .slideY(begin: 0.2, end: 0),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF7A6F5C),
                          ),
                        ).animate()
                         .fadeIn(duration: 400.ms, delay: 100.ms)
                         .slideY(begin: 0.2, end: 0),
                      ],
                    ),
                  ),
                  // Animated streak indicator
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: widget.streak > 0 ? [
                        BoxShadow(
                          color: widget.color.withOpacity(0.2 * _glowAnimation.value),
                          blurRadius: 8 * _glowAnimation.value,
                          offset: const Offset(0, 0),
                        ),
                      ] : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: widget.color,
                          size: 14,
                        ).animate(target: widget.streak > 0 ? 1 : 0)
                         .scale(begin: Offset(1, 1), end: Offset(1.2, 1.2))
                         .then()
                         .scale(begin: Offset(1.2, 1.2), end: Offset(1, 1)),
                        const SizedBox(width: 4),
                        TweenAnimationBuilder<int>(
                          tween: IntTween(begin: 0, end: widget.streak),
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Text(
                              '$value',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: widget.color,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ).animate()
                   .fadeIn(duration: 500.ms, delay: 200.ms)
                   .slideX(begin: 0.2, end: 0),
                ],
              ),

              const SizedBox(height: 20),

              // Animated progress bar with particles
              Stack(
                children: [
                  // Background bar
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),

                  // Animated progress bar
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Container(
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressAnimation.value.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  widget.color,
                                  widget.color.withOpacity(0.8),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.color.withOpacity(0.4 * _glowAnimation.value),
                                  blurRadius: 8 * _glowAnimation.value,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Animated particles for milestones
                  if (_progressAnimation.value >= 0.25)
                    Positioned(
                      left: 0.25 * 343 - 6,
                      top: -2,
                      child: Container(
                        width: 4,
                        height: 16,
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ).animate()
                       .fadeIn(duration: 300.ms)
                       .scale(begin: Offset(0.5, 0.5), end: Offset(1, 1)),
                    ),

                  if (_progressAnimation.value >= 0.5)
                    Positioned(
                      left: 0.5 * 343 - 6,
                      top: -2,
                      child: Container(
                        width: 4,
                        height: 16,
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ).animate()
                       .fadeIn(duration: 300.ms, delay: 200.ms)
                       .scale(begin: Offset(0.5, 0.5), end: Offset(1, 1)),
                    ),

                  if (_progressAnimation.value >= 0.75)
                    Positioned(
                      left: 0.75 * 343 - 6,
                      top: -2,
                      child: Container(
                        width: 4,
                        height: 16,
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ).animate()
                       .fadeIn(duration: 300.ms, delay: 400.ms)
                       .scale(begin: Offset(0.5, 0.5), end: Offset(1, 1)),
                    ),

                  if (_progressAnimation.value >= 1.0)
                    ...List.generate(5, (index) {
                      final angle = (index * 72.0) * math.pi / 180.0;
                      final distance = 20.0;
                      return Positioned(
                        left: 343 - 6 + math.cos(angle) * distance,
                        top: 6 + math.sin(angle) * distance,
                        child: Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: widget.color,
                            shape: BoxShape.circle,
                          ),
                        ).animate()
                         .fadeIn(duration: 200.ms, delay: Duration(milliseconds: index * 50))
                         .scale(begin: Offset(0, 0), end: Offset(1, 1))
                         .then()
                         .fadeOut(duration: 300.ms, delay: 500.ms),
                      );
                    }),
                ],
              ).animate()
               .fadeIn(duration: 600.ms, delay: 300.ms)
               .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 8),

              // Animated progress percentage
              Align(
                alignment: Alignment.centerRight,
                child: TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: (widget.progress * 100).round()),
                  duration: const Duration(milliseconds: 1000),
                  builder: (context, value, child) {
                    return Text(
                      '$value%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: widget.color,
                      ),
                    );
                  },
                ),
              ).animate()
               .fadeIn(duration: 400.ms, delay: 500.ms)
               .slideX(begin: 0.2, end: 0),

              // Achievement celebration for milestones
              if (widget.progress >= 1.0)
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.color.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.celebration,
                        color: widget.color,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Goal Achieved! 🎉',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: widget.color,
                        ),
                      ),
                    ],
                  ),
                ).animate()
                 .fadeIn(duration: 500.ms, delay: 800.ms)
                 .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1), curve: Curves.elasticOut),
            ],
          ),
        ).animate()
         .fadeIn(duration: 400.ms)
         .scale(begin: Offset(0.95, 0.95), end: Offset(1, 1), curve: Curves.easeOut);
      },
    );
  }
}
