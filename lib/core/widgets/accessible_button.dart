import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/utils/accessibility_utils.dart';
import 'package:vibration/vibration.dart';

/// Custom accessible button widget with built-in accessibility features
class AccessibleButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final String? semanticLabel;

  const AccessibleButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.semanticLabel,
  });

  @override
  State<AccessibleButton> createState() => _AccessibleButtonState();
}

class _AccessibleButtonState extends State<AccessibleButton> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  Future<void> _handlePress() async {
    if (widget.onPressed != null && !widget.isLoading) {
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 50);
      }
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;

    final buttonStyle = _getButtonStyle(theme, colors);
    final foregroundColor = _getForegroundColor(colors);

    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      button: true,
      enabled: widget.onPressed != null && !widget.isLoading,
      child: Focus(
        focusNode: _focusNode,
        child: Container(
          constraints: BoxConstraints(
            minWidth: AccessibilityUtils.minTouchTargetSize,
            minHeight: AccessibilityUtils.minTouchTargetSize,
          ),
          decoration: _isFocused
              ? BoxDecoration(
                  border: Border.all(
                    color: colors.primary,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          child: widget.type == ButtonType.text
              ? TextButton(
                  onPressed: widget.isLoading ? null : _handlePress,
                  style: buttonStyle,
                  child: _buildButtonContent(foregroundColor),
                )
              : widget.type == ButtonType.outlined
                  ? OutlinedButton(
                      onPressed: widget.isLoading ? null : _handlePress,
                      style: buttonStyle,
                      child: _buildButtonContent(foregroundColor),
                    )
                  : ElevatedButton(
                      onPressed: widget.isLoading ? null : _handlePress,
                      style: buttonStyle,
                      child: _buildButtonContent(foregroundColor),
                    ),
        ),
      ),
    );
  }

  Widget _buildButtonContent(Color foregroundColor) {
    if (widget.isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
        ),
      );
    }

    if (widget.icon != null) {
      return Row(
        mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, size: 20),
          const SizedBox(width: 8),
          Text(widget.label),
        ],
      );
    }

    return Text(widget.label);
  }

  ButtonStyle _getButtonStyle(ThemeData theme, CustomColors colors) {
    switch (widget.type) {
      case ButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(
            widget.isFullWidth ? double.infinity : AccessibilityUtils.minTouchTargetSize,
            AccessibilityUtils.minTouchTargetSize,
          ),
        );
      case ButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.onPrimaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(
            widget.isFullWidth ? double.infinity : AccessibilityUtils.minTouchTargetSize,
            AccessibilityUtils.minTouchTargetSize,
          ),
        );
      case ButtonType.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(
            widget.isFullWidth ? double.infinity : AccessibilityUtils.minTouchTargetSize,
            AccessibilityUtils.minTouchTargetSize,
          ),
        );
      case ButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: colors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(
            AccessibilityUtils.minTouchTargetSize,
            AccessibilityUtils.minTouchTargetSize,
          ),
        );
    }
  }

  Color _getForegroundColor(CustomColors colors) {
    switch (widget.type) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.secondary:
        return colors.onPrimaryContainer;
      case ButtonType.outlined:
      case ButtonType.text:
        return colors.primary;
    }
  }
}

enum ButtonType {
  primary,
  secondary,
  outlined,
  text,
}
