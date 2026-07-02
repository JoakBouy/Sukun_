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
import 'package:freud_ai/features/navigation/presentation/screens/main_navigation_screen.dart';
import 'package:freud_ai/features/onboarding/presentation/screens/onboarding_carousel_screen.dart';
import 'package:freud_ai/features/onboarding/presentation/screens/onboarding_view.dart';
import 'package:freud_ai/features/sessions/presentation/screens/sessions_screen.dart';
import 'package:freud_ai/features/therapist/presentation/screens/find_therapist_screen.dart';
import 'package:freud_ai/features/voice_journaling/presentation/screens/voice_journaling_screen.dart';
import 'package:freud_ai/features/exercises/presentation/screens/exercises_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/assessment_consent_screen.dart';
import 'package:freud_ai/features/journal/presentation/screens/journal_screen.dart';
import 'package:freud_ai/features/journal/presentation/screens/text_journal_editor_screen.dart';
import 'package:freud_ai/features/profile/presentation/screens/profile_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/phq9_assessment_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/dass21_assessment_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/asq_assessment_screen.dart';
import 'package:freud_ai/features/home/presentation/screens/metric_detail_screen.dart';
import 'package:freud_ai/features/exercises/presentation/screens/breathing_exercise_screen.dart';
import 'package:freud_ai/features/exercises/presentation/screens/relaxation_exercise_screen.dart';
import 'package:freud_ai/features/home/presentation/screens/notifications_screen.dart';
import 'package:freud_ai/features/home/presentation/screens/mood_selector.dart';
import 'package:freud_ai/features/profile/presentation/screens/habits_screen.dart';
import 'package:freud_ai/features/exercises/presentation/widgets/breathing_exercise_card.dart';
import 'package:freud_ai/features/chatbot/presentation/screens/ai_chatbot_screen.dart';
import 'package:freud_ai/features/community/presentation/screens/community_screen.dart';
// Removed: onboarding_screen.dart (duplicate onboarding)
import 'package:freud_ai/features/clinician/presentation/screens/primetel_portal_screen.dart';
import 'package:freud_ai/features/navigation/presentation/screens/doctor_navigation_screen.dart';
import 'package:freud_ai/features/navigation/presentation/screens/admin_navigation_screen.dart';
import 'package:freud_ai/features/resources/presentation/screens/resources_screen.dart';

class NavigationManager {
  static const String onboardingScreen = '/onboarding';
  static const String onboardingCarouselScreen = '/carousel';
  static const String authenticationScreen = '/authentication';
  static const String signUpScreen = '/signUp';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String assessmentMainScreen = '/assessmentMainScreen';
  static const String loadingScreen = '/loadingScreen';
  static const String endingScreen = '/endingScreen';
  static const String assessmentConsentScreen = '/assessmentConsent';
  static const String phq9AssessmentScreen = '/phq9Assessment';
  static const String dass21AssessmentScreen = '/dass21Assessment';
  static const String asqAssessmentScreen = '/asqAssessment';
  
  // Sukun App Routes
  static const String mainNavigation = '/mainNavigation';
  // Removed: newOnboarding route (duplicate onboarding)
  static const String mainNavigationScreen = '/main';
  static const String homeScreen = '/home';
  static const String exercisesScreen = '/exercises';
  static const String journalScreen = '/journal';
  static const String profileScreen = '/profile';
  static const String voiceJournalingScreen = '/voiceJournaling';
  static const String findTherapistScreen = '/findTherapist';
  static const String sessionsScreen = '/sessions';
  static const String messagingScreen = '/messaging';
  static const String moodTrackingScreen = '/moodTracking';
  static const String metricDetailScreen = '/metricDetail';
  static const String breathingExerciseScreen = '/breathingExercise';
  static const String relaxationExerciseScreen = '/relaxationExercise';
  static const String notificationsScreen = '/notifications';
  static const String moodSelectorScreen = '/moodSelector';
  static const String habitsScreen = '/habits';
  static const String crisisSupportScreen = '/crisisSupport';
  static const String textJournalEditorScreen = '/textJournalEditor';
  static const String aiChatbotScreen = '/aiChatbot';
  static const String communityScreen = '/community';
  static const String resourcesScreen = '/resources';
  
  // Primetel Health Clinician Portal
  static const String primetelPortalScreen = '/primetelPortal';

  // Doctor Portal Routes (TEMPORARY FOR TESTING)
  static const String doctorNavigationScreen = '/doctorNavigation';
  static const String adminNavigationScreen = '/adminNavigation';

  static Map<String, Widget Function(BuildContext)> routes = {
    onboardingScreen: (context) => const OnboardingView(),
    onboardingCarouselScreen: (context) => const OnboardingCarouselScreen(),
    authenticationScreen: (context) => const AuthenticationView(),
    signUpScreen: (context) => const SignUpScreen(),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
    assessmentMainScreen: (context) => const AssessmentMainScreen(),
    assessmentConsentScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      return AssessmentConsentScreen(assessmentType: args ?? 'phq9');
    },
    loadingScreen: (context) => const LoadingScreen(),
    endingScreen: (context) => const EndingScreen(),
    phq9AssessmentScreen: (context) => const PHQ9AssessmentScreen(),
    dass21AssessmentScreen: (context) => const DASS21AssessmentScreen(),
    asqAssessmentScreen: (context) => const ASQAssessmentScreen(),
    
    // Sukun App Routes
    mainNavigation: (context) => const MainNavigationScreen(),
    mainNavigationScreen: (context) => const MainNavigationScreen(),
    homeScreen: (context) => const HomeScreen(),
    exercisesScreen: (context) => const ExercisesScreen(),
    journalScreen: (context) => const JournalScreen(),
    profileScreen: (context) => const ProfileScreen(),
    voiceJournalingScreen: (context) => const VoiceJournalingScreen(),
    findTherapistScreen: (context) => const FindTherapistScreen(),
    sessionsScreen: (context) => const SessionsScreen(),
    messagingScreen: (context) => const MessagingScreen(),
    moodTrackingScreen: (context) => const MoodTrackingScreen(),
    metricDetailScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args == null) return const SizedBox(); // Handle null args gracefully
      return MetricDetailScreen(
        metricType: args['metricType'] ?? 'unknown',
        title: args['title'] ?? 'Metric',
        accentColor: args['accentColor'] ?? Colors.blue,
        currentValue: args['currentValue'] ?? '0',
        status: args['status'] ?? 'Unknown',
        message: args['message'] ?? 'No message',
      );
    },
    breathingExerciseScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args == null) return const SizedBox(); // Handle null args gracefully
      return BreathingExerciseScreen(
        title: args['title'] ?? 'Breathing Exercise',
        subtitle: args['subtitle'] ?? 'Relaxation technique',
        pattern: args['pattern'] ?? const BreathingPattern(
          inhaleDuration: 4,
          holdDuration: 4,
          exhaleDuration: 4,
          holdAfterExhaleDuration: 4,
          cycles: 4,
        ),
        accentColor: args['accentColor'] ?? Colors.blue,
      );
    },
    relaxationExerciseScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args == null) return const SizedBox(); // Handle null args gracefully
      return RelaxationExerciseScreen(
        title: args['title'] ?? 'Relaxation Exercise',
        subtitle: args['subtitle'] ?? 'Mindfulness technique',
        description: args['description'] ?? 'A guided relaxation exercise',
        accentColor: args['accentColor'] ?? Colors.blue,
        duration: args['duration'] ?? 10,
        instructions: args['instructions'] ?? ['Follow the guided instructions'],
      );
    },
    notificationsScreen: (context) => const NotificationsScreen(),
    moodSelectorScreen: (context) => const MoodSelectorScreen(),
    habitsScreen: (context) => const HabitsScreen(),
    crisisSupportScreen: (context) => const CrisisSupportScreen(),
    textJournalEditorScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      return TextJournalEditorScreen(
        initialPrompt: args?['initialPrompt'] as String?,
        existingTitle: args?['existingTitle'] as String?,
        existingContent: args?['existingContent'] as String?,
      );
    },
    aiChatbotScreen: (context) => const AiChatbotScreen(),
    communityScreen: (context) => const CommunityScreen(),
    resourcesScreen: (context) => const ResourcesScreen(),
    
    // Primetel Health Clinician Portal
    primetelPortalScreen: (context) => const PrimetelPortalScreen(),

    // Doctor Portal Routes (TEMPORARY FOR TESTING)
    doctorNavigationScreen: (context) => const PrimetelPortalScreen(),
    adminNavigationScreen: (context) => const AdminNavigationScreen(),
  };
}
