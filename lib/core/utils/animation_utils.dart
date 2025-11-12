import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animation utilities for consistent animations throughout the app
class AnimationUtils {
  // Standard animation durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  // Standard animation curves
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounceOut = Curves.bounceOut;

  /// Fade in animation for widgets appearing on screen
  static Effect fadeIn({
    Duration delay = Duration.zero,
    Duration duration = normal,
    Curve curve = easeOut,
  }) {
    return FadeEffect(
      delay: delay,
      duration: duration,
      curve: curve,
    );
  }

  /// Slide up animation for bottom-appearing content
  static Effect slideUp({
    Duration delay = Duration.zero,
    Duration duration = normal,
    Curve curve = easeOut,
  }) {
    return SlideEffect(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
      delay: delay,
      duration: duration,
      curve: curve,
    );
  }

  /// Scale animation for interactive elements
  static Effect scaleIn({
    Duration delay = Duration.zero,
    Duration duration = fast,
    Curve curve = easeOut,
    double begin = 0.8,
    double end = 1.0,
  }) {
    return ScaleEffect(
      begin: Offset(begin, begin),
      end: Offset(end, end),
      delay: delay,
      duration: duration,
      curve: curve,
    );
  }

  /// Bounce animation for celebratory moments
  static Effect bounce({
    Duration delay = Duration.zero,
    Duration duration = slow,
    Curve curve = bounceOut,
  }) {
    return ScaleEffect(
      begin: const Offset(0.8, 0.8),
      end: Offset.zero,
      delay: delay,
      duration: duration,
      curve: curve,
    );
  }

  /// Shimmer effect for loading states
  static Effect shimmer({
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return ShimmerEffect(
      delay: delay,
      duration: duration,
      color: Colors.white.withOpacity(0.3),
    );
  }

  /// Staggered animation for lists
  static List<Effect> staggeredFadeIn(int index, {
    Duration baseDelay = Duration.zero,
    Duration staggerDelay = const Duration(milliseconds: 100),
  }) {
    final delay = baseDelay + (staggerDelay * index);
    return [
      fadeIn(delay: delay),
      slideUp(delay: delay),
    ];
  }

  /// Pulse animation for breathing exercises
  static Effect breathingPulse({
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 4000),
  }) {
    return ScaleEffect(
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.2, 1.2),
      delay: delay,
      duration: duration ~/ 2,
      curve: Curves.easeInOut,
    );
  }

  /// Progress bar fill animation
  static Effect progressFill({
    required double targetValue,
    Duration delay = Duration.zero,
    Duration duration = slow,
    Curve curve = easeOut,
  }) {
    return CustomEffect(
      delay: delay,
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return LinearProgressIndicator(
          value: value * targetValue,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }

  /// Counter animation for numbers
  static Effect counterAnimation({
    required int targetValue,
    Duration delay = Duration.zero,
    Duration duration = slow,
    Curve curve = easeOut,
  }) {
    return CustomEffect(
      delay: delay,
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        final currentValue = (value * targetValue).round();
        return Text(
          currentValue.toString(),
          style: Theme.of(context).textTheme.headlineLarge,
        );
      },
    );
  }
}

/// Extension methods for easy animation chaining
extension AnimateExtension on Widget {
  /// Apply staggered animation to list items
  Widget animateStaggered(int index, {
    Duration baseDelay = Duration.zero,
    Duration staggerDelay = const Duration(milliseconds: 100),
  }) {
    return animate(
      effects: AnimationUtils.staggeredFadeIn(
        index,
        baseDelay: baseDelay,
        staggerDelay: staggerDelay,
      ),
    );
  }

  /// Apply breathing pulse animation
  Widget animateBreathing({
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 4000),
  }) {
    return animate(
      effects: [AnimationUtils.breathingPulse(delay: delay, duration: duration)],
    );
  }

  /// Apply card tap animation
  Widget animateCardTap() {
    return animate(
      effects: [
        ScaleEffect(
          begin: const Offset(1.0, 1.0),
          end: const Offset(0.95, 0.95),
          duration: AnimationUtils.fast,
          curve: Curves.easeInOut,
        ),
      ],
    );
  }

  /// Apply success celebration animation
  Widget animateSuccess() {
    return animate(
      effects: [
        ScaleEffect(
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.2, 1.2),
          duration: AnimationUtils.fast,
          curve: Curves.easeOut,
        ),
        ScaleEffect(
          begin: const Offset(1.2, 1.2),
          end: const Offset(1.0, 1.0),
          duration: AnimationUtils.fast,
          curve: Curves.bounceOut,
        ),
      ],
    );
  }
}
