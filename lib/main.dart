import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:freud_ai/core/providers/theme_provider.dart';
import 'package:freud_ai/core/providers/connectivity_provider.dart';
import 'package:freud_ai/core/data/local/database_helper.dart';
import 'package:freud_ai/core/data/local/cache_manager.dart';
import 'package:freud_ai/core/services/sync_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize offline support (skip on web as sqflite doesn't support it out of the box)
  if (!kIsWeb) {
    await DatabaseHelper.instance.database;
    await CacheManager.instance.init();
  }
  
  runApp(
    DevicePreview(
      defaultDevice: Devices.ios.iPhone16Pro,
      enabled: kIsWeb,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            ),
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
              title: 'Primetel Health',
              theme: ThemeManager.lightTheme,
              darkTheme: ThemeManager.darkTheme,
              themeMode: themeProvider.themeMode,
              themeAnimationCurve: Curves.easeInOut,
              themeAnimationDuration: const Duration(milliseconds: 300),
              home: const InitialRouteChecker(),
              routes: NavigationManager.routes,
              onUnknownRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Page Not Found'),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64),
                          const SizedBox(height: 16),
                          Text(
                            'Route not found: ${settings.name ?? 'unknown'}',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pushReplacementNamed(
                              NavigationManager.mainNavigationScreen,
                            ),
                            child: const Text('Go to Home'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class InitialRouteChecker extends StatefulWidget {
  const InitialRouteChecker({super.key});

  @override
  State<InitialRouteChecker> createState() => _InitialRouteCheckerState();
}

class _InitialRouteCheckerState extends State<InitialRouteChecker> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _checkFirstLaunch();
        }
      });
    });
  }

  Future<void> _checkFirstLaunch() async {
    if (kIsWeb) {
      Navigator.of(context).pushReplacementNamed(NavigationManager.primetelPortalScreen);
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;
    
    if (mounted) {
      if (hasCompletedOnboarding) {
        Navigator.of(context).pushReplacementNamed(NavigationManager.mainNavigation);
      } else {
        Navigator.of(context).pushReplacementNamed(NavigationManager.onboardingScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a simple loading indicator while checking
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
