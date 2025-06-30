class StringsManager {
  static const String fontFamily = 'urbanist';
  static const String onBoardingFirstTitle1 = 'Welcome to the ultimate';
  static const String onBoardingFirstTitle2 = ' freud ';
  static const String onBoardingFirstTitle3 = 'UI Kit!';
  static const String onBoardingFirstSubtitle =
      'Your mindful mental health AI companion for everyone, anywhere 🍃';
  static const String getStarted = 'Get Started';
  static const String continueButton = 'Continue';
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
  static const String assessmentTitle = 'Assessment';
  static const String assessmentTitle1 = 'What’s your health goal for today?';
  static const String assessmentTitle1Radio1 = 'I want to reduce stress';
  static const String assessmentTitle1Radio2 = 'I want to try AI therapy';
  static const String assessmentTitle1Radio3 = 'I want to cope with trauma';
  static const String assessmentTitle1Radio4 = 'I want to be a better person';
  static const String assessmentTitle1Radio5 = 'Just trying out the app, mate!';
  static const String assessmentTitle2 = 'What’s your official gender?';
  static const String male = 'I am Male';
  static const String female = 'I am Female';
  static const String assessment2SkipButton = 'Prefer to skip, thanks';
  static const String assessmentTitle3 = 'What’s your age?';
  static const String assessmentTitle4 = 'What’s your weight?';
  static const String assessmentTitle5 = 'How would you describe your mood?';
  static const String assessmentTitle6 =
      'Have you sought professional help before?';
  static const String assessmentTitle7 =
      'Are you experiencing any physical distress?';
  static const String assessmentTitle8 =
      'How would you rate your sleep quality?';
  static const String assessmentTitle9 = 'Are you taking any medications?';
  static const String assessmentTitle10 = 'Please specify your medications!';
  static const String assessmentTitle11 =
      'Do you have other mental health symptoms?';
  static const String assessmentTitle12 =
      'How would you rate your stress level?';
  static const String assessmentTitle13 = 'AI Sound Analysis';
  static const String assessmentTitle14 = 'Expression Analysis';
  static const String yesCardTitle = 'Yes, one or multiple';
  static const String yesCardSubtitle =
      'I’m experiencing physical pain in different place over my body.';
  static const String noCardTitle = 'No Physical Pain At All';
  static const String noCardSubtitle =
      'I’m not experiencing any physical pain in my body at all :)';
  static const String gridItem1 = 'Prescribed Medications';
  static const String gridItem2 = 'Over the Counter Supplements';
  static const String gridItem3 = 'I’m not taking any';
  static const String gridItem4 = 'Prefer not to say';

  static String onBoardingTopButton(int index) {
    switch (index) {
      case 1:
        return 'Step One';
      case 2:
        return 'Step Two';
      case 3:
        return 'Step Three';
      case 4:
        return 'Step Four';
      case 5:
        return 'Step Five';
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
