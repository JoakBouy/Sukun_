import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

/// A beautiful quick action tile with gradient background
class QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isPrimary;

  const QuickActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? LinearGradient(
                  colors: [color, color.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isPrimary ? null : colors.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isPrimary ? color.withOpacity(0.3) : Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isPrimary
                    ? Colors.white.withOpacity(0.2)
                    : color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isPrimary ? Colors.white : color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isPrimary ? Colors.white : colors.primary,
                fontFamily: 'urbanist',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A grid of quick action tiles
class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.85,
      children: [
        QuickActionTile(
          icon: Icons.chat_bubble_rounded,
          label: 'AI Chat',
          color: colors.orange,
          isPrimary: true,
          onTap: () => Navigator.pushNamed(context, '/aiChatbot'),
        ).animate().fadeIn(delay: const Duration(milliseconds: 100)).scale(begin: const Offset(0.8, 0.8)),
        QuickActionTile(
          icon: Icons.self_improvement,
          label: 'Meditate',
          color: colors.green,
          onTap: () => Navigator.pushNamed(context, '/exercises'),
        ).animate().fadeIn(delay: const Duration(milliseconds: 150)).scale(begin: const Offset(0.8, 0.8)),
        QuickActionTile(
          icon: Icons.edit_note,
          label: 'Journal',
          color: colors.violet,
          onTap: () => Navigator.pushNamed(context, '/textJournalEditor'),
        ).animate().fadeIn(delay: const Duration(milliseconds: 200)).scale(begin: const Offset(0.8, 0.8)),
        QuickActionTile(
          icon: Icons.people,
          label: 'Community',
          color: colors.yellow,
          onTap: () => Navigator.pushNamed(context, '/community'),
        ).animate().fadeIn(delay: const Duration(milliseconds: 250)).scale(begin: const Offset(0.8, 0.8)),
      ],
    );
  }
}
