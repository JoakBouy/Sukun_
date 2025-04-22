class StringsManager {
  static const String fontFamily = 'Urbanist';
  static const String onBoardingFirstTitle1 = 'Welcome to the ultimate';
  static const String onBoardingFirstTitle2 = ' freud ';
  static const String onBoardingFirstTitle3 = 'UI Kit!';
  static const String onBoardingFirstSubtitle =
      'Your mindful mental health AI companion for everyone, anywhere 🍃';
  static const String getStarted = 'Get Started';
  static const String alreadyHaveAnAccount = 'Already have an account? ';
  static const String noAccount = 'Don\'t have an account? ';
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String authenticationTitle = 'Sign In To freud.ai';
  static const String authenticationTitle2 = 'Sign Up For Free';
  static const String forgotPassword = 'Forgot Password';
  static const String email = 'Email Address';
  static const String email2 = 'Enter your email...';
  static const String password = 'Password';
  static const String password2 = 'Enter your password...';
  static const String confirmPassword = 'Password Confirmation';
  static const String confirmPassword2 = 'Confirm your password...';
  static const String forgotPasswordSubtitle =
      'Select contact details where you want to reset your password';
  static const String forgotPasswordListTitle1 = 'Use 2FA';
  static const String forgotPasswordListTitle2 = 'Password';
  static const String forgotPasswordListTitle3 = 'Google Authenticator';
  static const String sendPassword = 'Send Password';
  static const String resendPassword = 'Re-Send Password';
  static const String forgetPasswordPopup1 =
      'We’ve Sent Verification Code to ****-****-***24';
  static const String forgetPasswordPopup2 =
      'Didn’t receive the link? Then re-send the password below! 🔑';

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
