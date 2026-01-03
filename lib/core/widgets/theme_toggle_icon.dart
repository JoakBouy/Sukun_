import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:freud_ai/core/providers/theme_provider.dart';
import 'package:vibration/vibration.dart';
import 'dart:math' as math;

class ThemeToggleIcon extends StatefulWidget {
  const ThemeToggleIcon({super.key});

  @override
  State<ThemeToggleIcon> createState() => _ThemeToggleIconState();
}

class _ThemeToggleIconState extends State<ThemeToggleIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;
        
        // Robustly sync animation with state
        // This ensures the icon always matches the theme, regardless of how the state changed
        if (isDark) {
          _controller.forward();
        } else {
          _controller.reverse();
        }

        return IconButton(
          onPressed: () async {
            // Haptic feedback
            if (await Vibration.hasVibrator() ?? false) {
              Vibration.vibrate(duration: 15);
            }
            
            // Only toggle theme, let build handle animation
            themeProvider.toggleTheme();
          },
          tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
          icon: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * math.pi,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Sun Icon (Visible when light)
                    Transform.scale(
                      scale: 1 - _controller.value,
                      child: Opacity(
                        opacity: (1 - _controller.value).clamp(0.0, 1.0),
                        child: const Icon(
                          Icons.wb_sunny_rounded,
                          color: Colors.orange,
                          size: 24,
                        ),
                      ),
                    ),
                    // Moon Icon (Visible when dark)
                    Transform.scale(
                      scale: _controller.value,
                      child: Opacity(
                        opacity: _controller.value.clamp(0.0, 1.0),
                        child: const Icon(
                          Icons.nightlight_round,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
