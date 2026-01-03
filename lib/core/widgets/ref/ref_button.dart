import 'package:flutter/material.dart';
import 'package:freud_ai/core/widgets/accessible_button.dart';

class RefButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;

  const RefButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AccessibleButton(
      label: label,
      onPressed: onPressed,
      type: type,
      isLoading: isLoading,
      icon: icon,
      isFullWidth: true,
    );
  }
}
