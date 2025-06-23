import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freud_ai/core/managers/colors_manager.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final backColor =
        isDarkMode
            ? ColorsManager.backgroundDark
            : ColorsManager.backgroundLight;
    final oppositeBrightness = isDarkMode ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: backColor,
        systemNavigationBarIconBrightness: oppositeBrightness,
        statusBarIconBrightness: oppositeBrightness,
      ),
      child: Container(
        color: backColor,
        child: MaterialApp(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: false,
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: 'freud UI Kit',
          theme: isDarkMode ? ThemeManager.darkTheme : ThemeManager.lightTheme,
          initialRoute: NavigationManager.onboardingScreen,
          routes: NavigationManager.routes,
        ),
      ),
    );
  }
}
