import 'package:flutter/material.dart';
import 'package:playground/features/onboarding/presentation/screens/onboarding_view.dart';

class NavigationManager{
  static const String onboardingScreen = '';


  static Map<String, Widget Function(BuildContext)> routes = {
    onboardingScreen: (context) => const OnboardingView(),
  };
}