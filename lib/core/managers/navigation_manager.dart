import 'package:flutter/material.dart';
import 'package:freud_ai/features/authentication/presentation/screens/authentication_view.dart';
import 'package:freud_ai/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:freud_ai/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:freud_ai/features/crisis_support/presentation/screens/crisis_support_screen.dart';
import 'package:freud_ai/features/ending/presentation/screens/ending_screen.dart';
import 'package:freud_ai/features/ending/presentation/screens/loading_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/main_screen/assessment_main_screen.dart';
import 'package:freud_ai/features/home/presentation/screens/home_screen.dart';
import 'package:freud_ai/features/messaging/presentation/screens/messaging_screen.dart';
import 'package:freud_ai/features/mood_tracking/presentation/screens/mood_tracking_screen.dart';
import 'package:freud_ai/features/onboarding/presentation/screens/onboarding_carousel_screen.dart';
import 'package:freud_ai/features/onboarding/presentation/screens/onboarding_view.dart';
import 'package:freud_ai/features/sessions/presentation/screens/sessions_screen.dart';
import 'package:freud_ai/features/therapist/presentation/screens/find_therapist_screen.dart';
import 'package:freud_ai/features/voice_journaling/presentation/screens/voice_journaling_screen.dart';

class NavigationManager {
  static const String onboardingScreen = '/onboarding';
  static const String onboardingCarouselScreen = '/carousel';
  static const String authenticationScreen = '/authentication';
  static const String signUpScreen = '/signUp';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String assessmentMainScreen = '/assessmentMainScreen';
  static const String loadingScreen = '/loadingScreen';
  static const String endingScreen = '/endingScreen';
  
  // Sukun App Routes
  static const String homeScreen = '/home';
  static const String voiceJournalingScreen = '/voiceJournaling';
  static const String findTherapistScreen = '/findTherapist';
  static const String sessionsScreen = '/sessions';
  static const String messagingScreen = '/messaging';
  static const String moodTrackingScreen = '/moodTracking';
  static const String crisisSupportScreen = '/crisisSupport';

  static Map<String, Widget Function(BuildContext)> routes = {
    onboardingScreen: (context) => const OnboardingView(),
    onboardingCarouselScreen: (context) => const OnboardingCarouselScreen(),
    authenticationScreen: (context) => const AuthenticationView(),
    signUpScreen: (context) => const SignUpScreen(),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
    assessmentMainScreen: (context) => const AssessmentMainScreen(),
    loadingScreen: (context) => const LoadingScreen(),
    endingScreen: (context) => const EndingScreen(),
    
    // Sukun App Routes
    homeScreen: (context) => const HomeScreen(),
    voiceJournalingScreen: (context) => const VoiceJournalingScreen(),
    findTherapistScreen: (context) => const FindTherapistScreen(),
    sessionsScreen: (context) => const SessionsScreen(),
    messagingScreen: (context) => const MessagingScreen(),
    moodTrackingScreen: (context) => const MoodTrackingScreen(),
    crisisSupportScreen: (context) => const CrisisSupportScreen(),
  };
}
