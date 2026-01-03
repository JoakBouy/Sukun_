import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/utils/animation_constants.dart';
import 'package:vibration/vibration.dart';

/// Error types for the error banner
enum ErrorType {
  network,
  validation,
  server,
}

/// Animated error banner widget for displaying errors with retry functionality
class ErrorBanner extends StatefulWidget {
  final ErrorType type;
  final String message;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final Duration? autoDismissDuration;

  const ErrorBanner({
    super.key,
    required this.type,
    required this.message,
    this.onRetry,
    this.onDismiss,
    this.autoDismissDuration = const Duration(seconds: 5),
  });

  @override
  State<ErrorBanner> createState() => _ErrorBannerState();

  /// Show error banner as an overlay
  static void show({
    required BuildContext context,
    required ErrorType type,
    required String message,
    VoidCallback? onRetry,
    Duration? autoDismissDuration,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: ErrorBanner(
            type: type,
            message: message,
            onRetry: onRetry,
            autoDismissDuration: autoDismissDuration,
            onDismiss: () => overlayEntry.remove(),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _ErrorBannerState extends State<ErrorBanner> {
  Timer? _autoDismissTimer;

  @override
  void initState() {
    super.initState();
    _startAutoDismissTimer();
    _triggerHapticFeedback();
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    super.dispose();
  }

  void _startAutoDismissTimer() {
    if (widget.autoDismissDuration != null) {
      _autoDismissTimer = Timer(widget.autoDismissDuration!, () {
        if (mounted) {
          widget.onDismiss?.call();
        }
      });
    }
  }

  Future<void> _triggerHapticFeedback() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100, amplitude: 128);
    }
  }

  Color _getBackgroundColor(CustomColors colors) {
    switch (widget.type) {
      case ErrorType.network:
        return colors.orange;
      case ErrorType.validation:
        return colors.yellow;
      case ErrorType.server:
        return Colors.red;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.validation:
        return Icons.warning;
      case ErrorType.server:
        return Icons.error;
    }
  }

  String _getTitle() {
    switch (widget.type) {
      case ErrorType.network:
        return 'No Internet Connection';
      case ErrorType.validation:
        return 'Validation Error';
      case ErrorType.server:
        return 'Server Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final backgroundColor = _getBackgroundColor(colors);

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(),
                color: Colors.white,
                size: 24,
              ),
            ),

            const SizedBox(width: 12),

            // Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getTitle(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.onRetry != null)
                  IconButton(
                    onPressed: () async {
                      if (await Vibration.hasVibrator() ?? false) {
                        Vibration.vibrate(duration: 50);
                      }
                      widget.onRetry?.call();
                      widget.onDismiss?.call();
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    tooltip: 'Retry',
                  ),
                IconButton(
                  onPressed: () async {
                    if (await Vibration.hasVibrator() ?? false) {
                      Vibration.vibrate(duration: 50);
                    }
                    widget.onDismiss?.call();
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                  tooltip: 'Dismiss',
                ),
              ],
            ),
          ],
        ),
      )
          .animate()
          .slideY(
            begin: -1.0,
            end: 0.0,
            duration: Duration(milliseconds: AnimationConstants.durationNormal),
            curve: Curves.easeOut,
          )
          .fadeIn(
            duration: Duration(milliseconds: AnimationConstants.durationFast),
          ),
    );
  }
}
