import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animation utilities for consistent animations throughout the app
class AnimationUtils {
  // Standard animation durations
  static const Duration ultraFast = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Standard animation curves
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve spring = Curves.easeOutBack;

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

  /// Slide in from left animation
  static Effect slideInLeft({
    Duration delay = Duration.zero,
    Duration duration = normal,
    Curve curve = easeOut,
  }) {
    return SlideEffect(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
      delay: delay,
      duration: duration,
      curve: curve,
    );
  }

  /// Slide in from right animation
  static Effect slideInRight({
    Duration delay = Duration.zero,
    Duration duration = normal,
    Curve curve = easeOut,
  }) {
    return SlideEffect(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
      delay: delay,
      duration: duration,
      curve: curve,
    );
  }

  /// Blur effect for focus/unfocus
  static Effect blur({
    Duration delay = Duration.zero,
    Duration duration = normal,
    double begin = 0,
    double end = 5,
  }) {
    return BlurEffect(
      begin: Offset(begin, begin),
      end: Offset(end, end),
      delay: delay,
      duration: duration,
    );
  }

  /// Tint effect for color transitions
  static Effect tint({
    required Color color,
    Duration delay = Duration.zero,
    Duration duration = normal,
  }) {
    return TintEffect(
      color: color,
      delay: delay,
      duration: duration,
    );
  }

  /// Shake animation for errors
  static Effect shake({
    Duration delay = Duration.zero,
    Duration duration = fast,
  }) {
    return ShakeEffect(
      delay: delay,
      duration: duration,
      hz: 4,
      offset: const Offset(5, 0),
    );
  }

  /// Flip animation
  static Effect flip({
    Duration delay = Duration.zero,
    Duration duration = slow,
    Curve curve = easeInOut,
  }) {
    return FlipEffect(
      delay: delay,
      duration: duration,
      curve: curve,
    );
  }

  /// Elevation animation (shadow)
  static Effect elevate({
    Duration delay = Duration.zero,
    Duration duration = fast,
    double begin = 0,
    double end = 8,
  }) {
    return ElevationEffect(
      begin: begin,
      end: end,
      delay: delay,
      duration: duration,
    );
  }

  /// Combined card entrance animation
  static List<Effect> cardEntrance({
    Duration delay = Duration.zero,
    int index = 0,
  }) {
    final staggerDelay = delay + Duration(milliseconds: 50 * index);
    return [
      fadeIn(delay: staggerDelay, duration: normal),
      slideUp(delay: staggerDelay, duration: normal),
      scaleIn(delay: staggerDelay, duration: normal, begin: 0.95),
    ];
  }

  /// Interactive press animation
  static List<Effect> pressAnimation() {
    return [
      ScaleEffect(
        begin: const Offset(1.0, 1.0),
        end: const Offset(0.97, 0.97),
        duration: ultraFast,
        curve: easeOut,
      ),
    ];
  }

  /// Interactive release animation
  static List<Effect> releaseAnimation() {
    return [
      ScaleEffect(
        begin: const Offset(0.97, 0.97),
        end: const Offset(1.0, 1.0),
        duration: ultraFast,
        curve: spring,
      ),
    ];
  }

  /// Ripple effect animation
  static Effect ripple({
    Duration delay = Duration.zero,
    Duration duration = slow,
    Color? color,
  }) {
    return CustomEffect(
      delay: delay,
      duration: duration,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: (color ?? Theme.of(context).primaryColor).withOpacity(1 - value),
              width: 2,
            ),
          ),
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

  /// Apply card entrance animation
  Widget animateCardEntrance({
    Duration delay = Duration.zero,
    int index = 0,
  }) {
    return animate(
      effects: AnimationUtils.cardEntrance(delay: delay, index: index),
    );
  }

  /// Apply slide in from left
  Widget animateSlideInLeft({
    Duration delay = Duration.zero,
  }) {
    return animate(
      effects: [
        AnimationUtils.fadeIn(delay: delay),
        AnimationUtils.slideInLeft(delay: delay),
      ],
    );
  }

  /// Apply slide in from right
  Widget animateSlideInRight({
    Duration delay = Duration.zero,
  }) {
    return animate(
      effects: [
        AnimationUtils.fadeIn(delay: delay),
        AnimationUtils.slideInRight(delay: delay),
      ],
    );
  }

  /// Apply shake animation (for errors)
  Widget animateShake() {
    return animate(
      effects: [AnimationUtils.shake()],
    );
  }

  /// Apply shimmer loading effect
  Widget animateShimmer() {
    return animate(
      effects: [AnimationUtils.shimmer()],
    );
  }

  /// Apply flip animation
  Widget animateFlip({
    Duration delay = Duration.zero,
  }) {
    return animate(
      effects: [AnimationUtils.flip(delay: delay)],
    );
  }
}

/// Interactive widget wrapper for press animations
class AnimatedPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final double scale;

  const AnimatedPressable({
    super.key,
    required this.child,
    this.onTap,
    this.duration = AnimationUtils.ultraFast,
    this.scale = 0.97,
  });

  @override
  State<AnimatedPressable> createState() => _AnimatedPressableState();
}

class _AnimatedPressableState extends State<AnimatedPressable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
