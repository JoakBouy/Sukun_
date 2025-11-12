import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

/// Enhanced hero metric card with rich visualizations
/// Based on reference design with strong visual hierarchy
class HeroMetricCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final card = Container(
      constraints: const BoxConstraints(minWidth: 140, maxWidth: 163),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: [
          BoxShadow(
            color: accentColor.withOpacity(0.15),
            blurRadius: 32,
            offset: const Offset(0, 16),
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
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
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
            child: visualization,
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card.animateCardTap(),
      );
    }

    return card;
  }
}
