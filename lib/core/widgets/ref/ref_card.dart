import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_constants.dart';

class RefCard extends StatefulWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? backgroundColor;

  const RefCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
    this.backgroundColor,
  });

  @override
  State<RefCard> createState() => _RefCardState();
}

class _RefCardState extends State<RefCard> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AnimationConstants.durationShort),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap == null) return;
    _scaleController.forward();
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap == null) return;
    _scaleController.reverse();
    widget.onTap!();
  }

  void _handleTapCancel() {
    if (widget.onTap == null) return;
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget cardContent = Container(
      padding: const EdgeInsets.all(SizesManager.cardSpacing),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          widget.leading,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          if (widget.trailing != null) ...[
            const SizedBox(width: 16),
            widget.trailing!,
          ],
        ],
      ),
    );

    if (widget.onTap != null) {
      return Semantics(
        button: true,
        label: '${widget.title}, ${widget.subtitle}',
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
            child: cardContent,
          ),
        ),
      );
    }

    return Semantics(
      container: true,
      label: '${widget.title}, ${widget.subtitle}',
      child: cardContent,
    );
  }
}
