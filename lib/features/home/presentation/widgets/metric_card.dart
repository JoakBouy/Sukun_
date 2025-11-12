import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

/// A metric card that displays a value, label, and optional visualization
class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color backgroundColor;
  final Color accentColor;
  final Widget? visualization;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    required this.backgroundColor,
    required this.accentColor,
    this.visualization,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          shadows: [
            BoxShadow(
              color: accentColor.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            // Header with icon and label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.16,
                      ),
                    ),
                  ],
                ),
                // Placeholder for action button if needed
                SizedBox(width: 24, height: 24, child: Container()),
              ],
            ),
            // Value display
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w800,
                letterSpacing: -0.24,
              ),
            ),
            // Optional visualization
            if (visualization != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: visualization!,
              ),
          ],
        ),
      ),
    );
  }
}
