import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/navigation_manager.dart';
import 'package:playground/core/managers/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: ThemeManager.lightTheme.scaffoldBackgroundColor,
      systemNavigationBarColor: ThemeManager.lightTheme.scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.backgroundLight,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'freud UI Kit',
        theme: ThemeManager.lightTheme,
        initialRoute: NavigationManager.onboardingScreen,
        routes: NavigationManager.routes,
      ),
    );
  }
}
