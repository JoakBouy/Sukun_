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
  static const String solidHeart = '$svg/solid_heart.svg';
  static const String solidRobot = '$svg/solid_robot.svg';
  static const String solidFlag = '$svg/solid_flag.svg';
  static const String solidHappy = '$svg/solid_happy.svg';
  static const String solidMobile = '$svg/solid_mobile.svg';
  static const String maleIcon = '$svg/male_icon.svg';
  static const String femaleIcon = '$svg/female_icon.svg';
  static const String X = '$svg/X.svg';

  static String getIcon(isDarkMode) {
    return '$svg/$isDarkMode/icon.svg';
  }

  static String getOnboarding(isDarkMode, number) {
    return '$svg/$isDarkMode/onboarding_$number.svg';
  }

  static String forgotPassword(isDarkMode) {
    return '$svg/$isDarkMode/forgot_password.svg';
  }

  static String getMale(isDarkMode) {
    return '$svg/$isDarkMode/male.svg';
  }

  static String getFemale(isDarkMode) {
    return '$svg/$isDarkMode/female.svg';
  }
}
