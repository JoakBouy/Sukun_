import 'package:flutter/material.dart';

class CustomAssets extends ThemeExtension<CustomAssets> {
  final String arrow = 'assets/images/svgs/arrow.svg';
  final String arrow2 = 'assets/images/svgs/arrow2.svg';
  final String iconWhite = 'assets/images/svgs/Icon_white.svg';
  final String email = 'assets/images/svgs/email.svg';
  final String lock = 'assets/images/svgs/lock.svg';
  final String eye = 'assets/images/svgs/eye.svg';
  final String facebook = 'assets/images/svgs/facebook.svg';
  final String google = 'assets/images/svgs/google.svg';
  final String instagram = 'assets/images/svgs/instagram.svg';
  final String back = 'assets/images/svgs/back.svg';
  final String p_2fa = 'assets/images/svgs/2fa.svg';
  final String password = 'assets/images/svgs/password.svg';
  final String googleAuth = 'assets/images/svgs/google_auth.svg';
  final String solidHeart = 'assets/images/svgs/solid_heart.svg';
  final String solidRobot = 'assets/images/svgs/solid_robot.svg';
  final String solidFlag = 'assets/images/svgs/solid_flag.svg';
  final String solidHappy = 'assets/images/svgs/solid_happy.svg';
  final String solidMobile = 'assets/images/svgs/solid_mobile.svg';
  final String maleIcon = 'assets/images/svgs/male_icon.svg';
  final String femaleIcon = 'assets/images/svgs/female_icon.svg';
  final String X = 'assets/images/svgs/X.svg';
  final String wheelSelector = 'assets/images/svgs/wheel_selector.svg';
  final String emoji1 = 'assets/images/svgs/emoji1.svg';
  final String emoji2 = 'assets/images/svgs/emoji2.svg';
  final String emoji3 = 'assets/images/svgs/emoji3.svg';
  final String emoji4 = 'assets/images/svgs/emoji4.svg';
  final String emoji5 = 'assets/images/svgs/emoji5.svg';
  final String pointer = 'assets/images/svgs/pointer.svg';
  final String icon;
  final String onboarding0;
  final String onboarding1;
  final String onboarding2;
  final String onboarding3;
  final String onboarding4;
  final String onboarding5;
  final String forgotPassword;
  final String male;
  final String female;
  final String page6;
  const CustomAssets({
    required this.icon,
    required this.onboarding0,
    required this.onboarding1,
    required this.onboarding2,
    required this.onboarding3,
    required this.onboarding4,
    required this.onboarding5,
    required this.forgotPassword,
    required this.male,
    required this.female,
    required this.page6,
  });

  @override
  ThemeExtension<CustomAssets> copyWith({
    String? icon,
    String? onboarding0,
    String? onboarding1,
    String? onboarding2,
    String? onboarding3,
    String? onboarding4,
    String? onboarding5,
    String? forgotPassword,
    String? male,
    String? female,
    String? page6,
  }) {
    return CustomAssets(
      icon: icon ?? this.icon,
      onboarding0: onboarding1 ?? this.onboarding0,
      onboarding1: onboarding1 ?? this.onboarding1,
      onboarding2: onboarding2 ?? this.onboarding2,
      onboarding3: onboarding3 ?? this.onboarding3,
      onboarding4: onboarding4 ?? this.onboarding4,
      onboarding5: onboarding5 ?? this.onboarding5,
      forgotPassword: forgotPassword ?? this.forgotPassword,
      male: male ?? this.male,
      female: female ?? this.female,
      page6: page6 ?? this.page6,
    );
  }

  @override
  ThemeExtension<CustomAssets> lerp(
    ThemeExtension<CustomAssets>? other,
    double t,
  ) {
    if (other is! CustomAssets) return this;
    return CustomAssets(
      icon: other.icon,
      onboarding0: other.onboarding0,
      onboarding1: other.onboarding1,
      onboarding2: other.onboarding2,
      onboarding3: other.onboarding3,
      onboarding4: other.onboarding4,
      onboarding5: other.onboarding5,
      forgotPassword: other.forgotPassword,
      male: other.male,
      female: other.female,
      page6: other.page6,
    );
  }

  static const CustomAssets light = CustomAssets(
    icon: 'assets/images/svgs/light/icon.svg',
    onboarding0: 'assets/images/svgs/light/onboarding_0.svg',
    onboarding1: 'assets/images/svgs/light/onboarding_1.svg',
    onboarding2: 'assets/images/svgs/light/onboarding_2.svg',
    onboarding3: 'assets/images/svgs/light/onboarding_3.svg',
    onboarding4: 'assets/images/svgs/light/onboarding_4.svg',
    onboarding5: 'assets/images/svgs/light/onboarding_5.svg',
    forgotPassword: 'assets/images/svgs/light/forgot_password.svg',
    male: 'assets/images/svgs/light/male.svg',
    female: 'assets/images/svgs/light/female.svg',
    page6: 'assets/images/svgs/light/page6.svg',
  );
  static const CustomAssets dark = CustomAssets(
    icon: 'assets/images/svgs/dark/icon.svg',
    onboarding0: 'assets/images/svgs/dark/onboarding_0.svg',
    onboarding1: 'assets/images/svgs/dark/onboarding_1.svg',
    onboarding2: 'assets/images/svgs/dark/onboarding_2.svg',
    onboarding3: 'assets/images/svgs/dark/onboarding_3.svg',
    onboarding4: 'assets/images/svgs/dark/onboarding_4.svg',
    onboarding5: 'assets/images/svgs/dark/onboarding_5.svg',
    forgotPassword: 'assets/images/svgs/dark/forgot_password.svg',
    male: 'assets/images/svgs/dark/male.svg',
    female: 'assets/images/svgs/dark/female.svg',
    page6: 'assets/images/svgs/dark/page6.svg',
  );
}
