import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/utils/animation_constants.dart';
import 'package:vibration/vibration.dart';

/// Confirmation dialog for destructive actions
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String primaryButtonLabel;
  final String secondaryButtonLabel;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final IconData? icon;
  final Color? iconColor;
  final bool isPrimaryDestructive;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.primaryButtonLabel = 'Confirm',
    this.secondaryButtonLabel = 'Cancel',
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.icon,
    this.iconColor,
    this.isPrimaryDestructive = false,
  });

  /// Show confirmation dialog
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String primaryButtonLabel = 'Confirm',
    String secondaryButtonLabel = 'Cancel',
    IconData? icon,
    Color? iconColor,
    bool isPrimaryDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialog(
        title: title,
        message: message,
        primaryButtonLabel: primaryButtonLabel,
        secondaryButtonLabel: secondaryButtonLabel,
        icon: icon,
        iconColor: iconColor,
        isPrimaryDestructive: isPrimaryDestructive,
        onPrimaryAction: () => Navigator.of(context).pop(true),
        onSecondaryAction: () => Navigator.of(context).pop(false),
      ),
    );
  }

  Future<void> _triggerHapticFeedback() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: colors.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon (if provided)
            if (icon != null) ...[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: (iconColor ?? colors.primary).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? colors.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Title
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onPrimaryContainer,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                // Secondary button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await _triggerHapticFeedback();
                      onSecondaryAction?.call();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      secondaryButtonLabel,
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Primary button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _triggerHapticFeedback();
                      onPrimaryAction?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPrimaryDestructive ? Colors.red : colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      primaryButtonLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: Duration(milliseconds: AnimationConstants.durationNormal),
          curve: Curves.easeOut,
        )
        .fadeIn(
          duration: Duration(milliseconds: AnimationConstants.durationFast),
        );
  }
}
