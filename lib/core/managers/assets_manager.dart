class AssetsManager {
  static const String svg = 'assets/images/svgs';
  static const String png = 'assets/images';
  static const String arrow = '$svg/arrow.svg';
  static String getOnboarding0(isDarkMode){
    return '$svg/$isDarkMode/onboarding_0.svg';
  }
  static String getIcon(isDarkMode){
    return '$svg/$isDarkMode/icon.svg';
  }
}