import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:freud_ai/core/providers/theme_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return GestureDetector(
          onTap: () => themeProvider.toggleTheme(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 70,
            height: 36,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? Colors.black : Colors.grey.shade300).withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background gradient
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [Colors.grey.shade700, Colors.grey.shade900]
                          : [Colors.white, Colors.grey.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                // Toggle button
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: isDark ? 34 : 2,
                  top: 2,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? Colors.grey.shade900 : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.5 : 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: isDark ? Colors.orange.shade300 : Colors.orange.shade500,
                      size: 18,
                    ),
                  ),
                ),

                // Sun/Moon icons
                Positioned(
                  left: 8,
                  top: 8,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isDark ? 0.3 : 1.0,
                    child: Icon(
                      Icons.light_mode,
                      color: isDark ? Colors.grey.shade600 : Colors.orange.shade400,
                      size: 20,
                    ),
                  ),
                ),

                Positioned(
                  right: 8,
                  top: 8,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isDark ? 1.0 : 0.3,
                    child: Icon(
                      Icons.dark_mode,
                      color: isDark ? Colors.blue.shade300 : Colors.grey.shade400,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ).animate()
           .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1))
           .fadeIn(duration: 300.ms),
        );
      },
    );
  }
}
