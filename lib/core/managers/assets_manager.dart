class AssetsManager {
  static const String svg = 'assets/images/svgs';
  static const String png = 'assets/images';
  static const String arrow = '$svg/arrow.svg';
  static const String arrow2 = '$svg/arrow2.svg';
  static const String iconWhite = '$svg/Icon_white.svg';
  static const String email = '$svg/email.svg';
  static const String lock = '$svg/lock.svg';
  static const String eye = '$svg/eye.svg';
  static const String facebook = '$svg/facebook.svg';
  static const String google = '$svg/google.svg';
  static const String instagram = '$svg/instagram.svg';
  static const String back = '$svg/back.svg';
  static const String p_2fa = '$svg/2fa.svg';
  static const String password = '$svg/password.svg';
  static const String googleAuth = '$svg/google_auth.svg';

  static String getIcon(isDarkMode) {
    return '$svg/$isDarkMode/icon.svg';
  }

  static String getOnboarding(isDarkMode, number) {
    return '$svg/$isDarkMode/onboarding_$number.svg';
  }

  static String getOnboardingC(isDarkMode) {
    return '$svg/$isDarkMode/onboardingC.svg';
  }

  static String forgotPassword(isDarkMode) {
    return '$svg/$isDarkMode/forgot_password.svg';
  }
}
