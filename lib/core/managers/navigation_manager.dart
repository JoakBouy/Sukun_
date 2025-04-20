import 'package:flutter/material.dart';
import 'package:playground/features/authentication/presentation/screens/authentication_view.dart';
import 'package:playground/features/onboarding/presentation/screens/onboarding_carousel_screen.dart';
import 'package:playground/features/onboarding/presentation/screens/onboarding_view.dart';

class NavigationManager {
  static const String onboardingScreen = '/onboarding';
  static const String onboardingCarouselScreen = '/carousel';
  static const String authenticationScreen = '/authentication';

  static Map<String, Widget Function(BuildContext)> routes = {
    onboardingScreen: (context) => const OnboardingView(),
    onboardingCarouselScreen: (context) => const OnboardingCarouselScreen(),
    authenticationScreen: (context) => const AuthenticationView(),
  };
}
