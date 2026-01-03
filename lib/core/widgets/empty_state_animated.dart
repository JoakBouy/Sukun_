import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_constants.dart';

/// Animated empty state widget with illustration and action button
class EmptyStateAnimated extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? iconColor;

  const EmptyStateAnimated({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final effectiveIconColor = iconColor ?? colors.primary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SizesManager.dPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with animation
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: effectiveIconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: effectiveIconColor,
              ),
            )
                .animate()
                .fadeIn(
                  duration: Duration(milliseconds: AnimationConstants.fadeInDuration),
                )
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: Duration(milliseconds: AnimationConstants.scaleInDuration),
                  curve: Curves.easeOut,
                ),

            const SizedBox(height: SizesManager.dPadding),

            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: AnimationConstants.initialDelay),
                  duration: Duration(milliseconds: AnimationConstants.fadeInDuration),
                )
                .slideY(
                  begin: 0.2,
                  end: 0,
                  delay: Duration(milliseconds: AnimationConstants.initialDelay),
                  duration: Duration(milliseconds: AnimationConstants.slideInDuration),
                ),

            const SizedBox(height: SizesManager.vPadding),

            // Message
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onBackground.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: AnimationConstants.shortDelay),
                  duration: Duration(milliseconds: AnimationConstants.fadeInDuration),
                )
                .slideY(
                  begin: 0.2,
                  end: 0,
                  delay: Duration(milliseconds: AnimationConstants.shortDelay),
                  duration: Duration(milliseconds: AnimationConstants.slideInDuration),
                ),

            // Action button
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: SizesManager.dPadding),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SizesManager.dPadding,
                    vertical: SizesManager.padding,
                  ),
                ),
                child: Text(actionLabel!),
              )
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: AnimationConstants.mediumDelay),
                    duration: Duration(milliseconds: AnimationConstants.fadeInDuration),
                  )
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1.0, 1.0),
                    delay: Duration(milliseconds: AnimationConstants.mediumDelay),
                    duration: Duration(milliseconds: AnimationConstants.scaleInDuration),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}
