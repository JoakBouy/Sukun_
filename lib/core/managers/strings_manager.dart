class StringsManager {
  static const String onBoardingFirstTitle1 = 'Welcome to the ultimate';
  static const String onBoardingFirstTitle2 = ' freud ';
  static const String onBoardingFirstTitle3 = 'UI Kit!';
  static const String onBoardingFirstSubtitle =
      'Your mindful mental health AI companion for everyone, anywhere 🍃';
  static const String getStarted = 'Get Started';
  static const String alreadyHaveAnAccount = 'Already have an account? ';
  static const String signIn = 'Sign In';
  static const String onBoardingSecondTitle = 'Your Mental Health Companion';
  static const String fontFamily = 'Urbanist';

  static String onBoardingTopButton(int index) {
    switch (index) {
      case 1:
        return 'Step One';
      case 2:
        return 'Step two';
      case 3:
        return 'Step three';
      case 4:
        return 'Step four';
      case 5:
        return 'Step five';
      default:
        return '';
    }
  }

  static String onBoardingTitle1(int index) {
    switch (index) {
      case 1:
        return 'Personalize Your Mental';
      case 2:
        return '';
      case 3:
        return 'AI';
      case 4:
        return 'Mindful';
      case 5:
        return 'Loving & Supportive';
      default:
        return '';
    }
  }
  static String onBoardingTitle2(int index) {
    switch (index) {
      case 1:
        return ' Health State ';
      case 2:
        return 'Intelligent ';
      case 3:
        return ' Mental ';
      case 4:
        return ' Resources ';
      case 5:
        return ' Community';
      default:
        return '';
    }
  }
  static String onBoardingTitle3(int index) {
    switch (index) {
      case 1:
        return 'With AI';
      case 2:
        return 'Mood Tracking & AI Emotion Insights';
      case 3:
        return 'Journaling & AI Therapy Chatbot';
      case 4:
        return 'That Makes You Happy';
      case 5:
        return '';
      default:
        return '';
    }
  }

}
