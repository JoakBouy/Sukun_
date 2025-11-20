import 'package:flutter/material.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

/// An animated card widget with press, hover, and entrance animations
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  final bool enablePressAnimation;
  final bool enableHoverAnimation;
  final Duration animationDuration;
  final double pressScale;
  final double hoverElevation;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.color,
    this.elevation = 2,
    this.borderRadius,
    this.enablePressAnimation = true,
    this.enableHoverAnimation = true,
    this.animationDuration = AnimationUtils.fast,
    this.pressScale = 0.97,
    this.hoverElevation = 8,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pressScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: widget.elevation ?? 2,
      end: widget.hoverElevation,
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
    if (widget.enablePressAnimation && widget.onTap != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enablePressAnimation && widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
      widget.onTap?.call();
    }
  }

  void _handleTapCancel() {
    if (widget.enablePressAnimation) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleHoverEnter(PointerEnterEvent event) {
    if (widget.enableHoverAnimation && !_isPressed) {
      setState(() => _isHovered = true);
      _controller.forward();
    }
  }

  void _handleHoverExit(PointerExitEvent event) {
    if (widget.enableHoverAnimation && !_isPressed) {
      setState(() => _isHovered = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget card = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = widget.enablePressAnimation && _isPressed
            ? _scaleAnimation.value
            : 1.0;
        final elevation = widget.enableHoverAnimation && _isHovered
            ? _elevationAnimation.value
            : widget.elevation ?? 2;

        return Transform.scale(
          scale: scale,
          child: Card(
            elevation: elevation,
            color: widget.color,
            margin: widget.margin,
            shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            ),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(16),
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );

    if (widget.onTap != null) {
      card = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: MouseRegion(
          onEnter: _handleHoverEnter,
          onExit: _handleHoverExit,
          cursor: SystemMouseCursors.click,
          child: card,
        ),
      );
    }

    return card;
  }
}

