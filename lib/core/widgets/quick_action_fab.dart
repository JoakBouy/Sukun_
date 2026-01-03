import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/utils/animation_constants.dart';
import 'package:vibration/vibration.dart';
import 'package:freud_ai/core/widgets/glass_container.dart';

/// Quick Action FAB with speed dial menu for common actions
class QuickActionFAB extends StatefulWidget {
  const QuickActionFAB({super.key});

  @override
  State<QuickActionFAB> createState() => _QuickActionFABState();
}

class _QuickActionFABState extends State<QuickActionFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  bool _isExpanded = false;

  final List<_QuickAction> _actions = [
    _QuickAction(
      icon: Icons.edit_note,
      label: 'New Journal',
      color: const Color(0xFF9BB068),
      route: NavigationManager.textJournalEditorScreen,
    ),
    _QuickAction(
      icon: Icons.calendar_today,
      label: 'Sessions',
      color: const Color(0xFFA18EFF),
      route: NavigationManager.sessionsScreen,
    ),
    _QuickAction(
      icon: Icons.mood,
      label: 'Mood Check-in',
      color: const Color(0xFFFFCE5B),
      route: NavigationManager.moodTrackingScreen,
    ),
    _QuickAction(
      icon: Icons.emergency,
      label: 'SOS',
      color: Colors.red,
      route: NavigationManager.crisisSupportScreen,
    ),
    _QuickAction(
      icon: Icons.smart_toy,
      label: 'AI Companion',
      color: const Color(0xFF4B3425),
      route: NavigationManager.aiChatbotScreen,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: AnimationConstants.durationNormal),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.125, // 45 degrees (1/8 turn)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() async {
    // Haptic feedback
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50);
    }

    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _handleAction(_QuickAction action) async {
    // Haptic feedback
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50);
    }

    // Close the menu
    _toggle();

    // Navigate after a short delay for smooth animation
    await Future.delayed(Duration(milliseconds: AnimationConstants.durationFast));
    if (mounted) {
      Navigator.pushNamed(context, action.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Backdrop overlay
        if (_isExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggle,
              child: GlassContainer(
                blur: 10,
                opacity: 0.2,
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),
            ).animate().fadeIn(
                  duration: Duration(milliseconds: AnimationConstants.durationFast),
                ),
          ),

        // Speed dial items
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                _actions.length,
                (index) {
                  final action = _actions[_actions.length - 1 - index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _SpeedDialItem(
                      action: action,
                      onTap: () => _handleAction(action),
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ),

        // Main FAB
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: FloatingActionButton(
                  onPressed: _toggle,
                  backgroundColor: colors.green,
                  child: Icon(
                    _isExpanded ? Icons.close : Icons.add,
                    color: colors.primaryContainer,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SpeedDialItem extends StatelessWidget {
  final _QuickAction action;
  final VoidCallback onTap;
  final int index;

  const _SpeedDialItem({
    required this.action,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            action.label,
            style: TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Action button
        FloatingActionButton(
          mini: true,
          onPressed: onTap,
          backgroundColor: action.color,
          heroTag: action.label,
          child: Icon(
            action.icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: AnimationConstants.staggerShort * index),
          duration: Duration(milliseconds: AnimationConstants.durationFast),
        )
        .slideX(
          begin: 0.2,
          end: 0,
          delay: Duration(milliseconds: AnimationConstants.staggerShort * index),
          duration: Duration(milliseconds: AnimationConstants.durationFast),
        );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final String route;

  _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });
}
