import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:freud_ai/core/providers/theme_provider.dart';

class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              key: ValueKey<bool>(isDark),
              color: Theme.of(context).appBarTheme.foregroundColor ?? Colors.black,
              size: 24,
            ),
          ),
          onPressed: () => themeProvider.toggleTheme(),
          tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
        );
      },
    );
  }
}
