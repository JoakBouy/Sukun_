class AssetsManager {
  static const String svg = 'assets/images/svgs';
  static const String png = 'assets/images';
  static const String arrow = '$svg/arrow.svg';
  static const String arrow2 = '$svg/arrow2.svg';
  static String getIcon(isDarkMode) {
    return '$svg/$isDarkMode/icon.svg';
  }

  static String getOnboarding(isDarkMode, number) {
    return '$svg/$isDarkMode/onboarding_$number.svg';
  }

  static String getOnboardingC(isDarkMode) {
    return '$svg/$isDarkMode/onboardingC.svg';
  }
}
