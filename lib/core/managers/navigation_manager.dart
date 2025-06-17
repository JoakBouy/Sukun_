import 'package:flutter/material.dart';
import 'package:freud_ai/features/authentication/presentation/screens/authentication_view.dart';
import 'package:freud_ai/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:freud_ai/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/main_screen/assessment_main_screen.dart';
import 'package:freud_ai/features/onboarding/presentation/screens/onboarding_carousel_screen.dart';
import 'package:freud_ai/features/onboarding/presentation/screens/onboarding_view.dart';

class NavigationManager {
  static const String onboardingScreen = '/onboarding';
  static const String onboardingCarouselScreen = '/carousel';
  static const String authenticationScreen = '/authentication';
  static const String signUpScreen = '/signUp';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String assessmentMainScreen = '/assessmentMainScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    onboardingScreen: (context) => const OnboardingView(),
    onboardingCarouselScreen: (context) => const OnboardingCarouselScreen(),
    authenticationScreen: (context) => const AuthenticationView(),
    signUpScreen: (context) => const SignUpScreen(),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
    assessmentMainScreen: (context) => const AssessmentMainScreen(),
  };
}
