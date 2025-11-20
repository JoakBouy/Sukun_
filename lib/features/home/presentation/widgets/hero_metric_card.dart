import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

/// Enhanced hero metric card with rich visualizations
/// Based on reference design with strong visual hierarchy
class HeroMetricCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color accentColor;
  final Widget visualization;
  final VoidCallback? onTap;

  const HeroMetricCard({
    super.key,
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.visualization,
    this.onTap,
  });

  @override
  State<HeroMetricCard> createState() => _HeroMetricCardState();
}

class _HeroMetricCardState extends State<HeroMetricCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _shadowAnimation = Tween<double>(
      begin: 32.0,
      end: 16.0,
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

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
      widget.onTap?.call();
    }
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final card = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            constraints: const BoxConstraints(minWidth: 140, maxWidth: 163),
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              color: widget.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              shadows: [
                BoxShadow(
                  color: widget.accentColor.withOpacity(0.15),
                  blurRadius: _shadowAnimation.value,
                  offset: Offset(0, _shadowAnimation.value / 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title with icon
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 20,
                    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .shimmer(
                        delay: const Duration(seconds: 2),
                        duration: const Duration(seconds: 2),
                        color: Colors.white.withOpacity(0.3),
                      ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Visualization
                SizedBox(
                  height: 120,
                  child: widget.visualization,
                ),
              ],
            ),
          ),
        );
      },
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: card,
      );
    }

    return card;
  }
}
