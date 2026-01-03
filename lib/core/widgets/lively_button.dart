import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_constants.dart';

class LivelyButton extends StatefulWidget {
  final String? label;
  final Widget? child;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;
  final IconData? icon;
  final LinearGradient? gradient;
  final Color? color;
  final Color? textColor;
  final double width;
  final double height;
  final bool usePulse;
  final bool enablePulse;

  const LivelyButton({
    super.key,
    this.label,
    this.child,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.icon,
    this.gradient,
    this.color,
    this.textColor,
    this.width = double.infinity,
    this.height = 56.0,
    this.usePulse = false,
    this.enablePulse = false,
  }) : assert(label != null || child != null, 'Either label or child must be provided');

  @override
  State<LivelyButton> createState() => _LivelyButtonState();
}

class _LivelyButtonState extends State<LivelyButton> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AnimationConstants.durationShort),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => _isPressed = true);
    _scaleController.forward();
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => _isPressed = false);
    _scaleController.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Determine colors
    final effectiveGradient = widget.isEnabled 
        ? widget.gradient 
        : null;
    
    final effectiveColor = widget.isEnabled
        ? (widget.color ?? theme.colorScheme.primary)
        : theme.disabledColor;
        
    final effectiveTextColor = widget.isEnabled
        ? (widget.textColor ?? theme.colorScheme.onPrimary)
        : theme.colorScheme.onSurface.withOpacity(0.38);

    return Semantics(
      button: true,
      enabled: widget.isEnabled,
      label: widget.label,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: effectiveGradient,
              color: effectiveGradient == null ? effectiveColor : null,
              borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
              boxShadow: widget.isEnabled && !widget.isLoading && !_isPressed
                  ? [
                      BoxShadow(
                        color: (effectiveGradient?.colors.first ?? effectiveColor).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                      ),
                    )
                  : widget.child ?? Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         if (widget.icon != null) ...[
                           Icon(widget.icon, color: effectiveTextColor),
                           const SizedBox(width: 8),
                         ],
                         Text(
                           widget.label ?? '',
                           style: theme.textTheme.titleMedium?.copyWith(
                             color: effectiveTextColor,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ],
                     ),
            ),
          ),
        ),
      ),
    );
  }
}
