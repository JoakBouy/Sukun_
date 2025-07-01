import 'package:flutter/material.dart';

class CustomAssets extends ThemeExtension<CustomAssets> {
  final String arrow = 'assets/images/svgs/arrow.svg.vec';
  final String arrow2 = 'assets/images/svgs/arrow2.svg.vec';
  final String iconWhite = 'assets/images/svgs/Icon_white.svg.vec';
  final String email = 'assets/images/svgs/email.svg.vec';
  final String lock = 'assets/images/svgs/lock.svg.vec';
  final String eye = 'assets/images/svgs/eye.svg.vec';
  final String facebook = 'assets/images/svgs/facebook.svg.vec';
  final String google = 'assets/images/svgs/google.svg.vec';
  final String instagram = 'assets/images/svgs/instagram.svg.vec';
  final String back = 'assets/images/svgs/back.svg.vec';
  final String p_2fa = 'assets/images/svgs/2fa.svg.vec';
  final String password = 'assets/images/svgs/password.svg.vec';
  final String googleAuth = 'assets/images/svgs/google_auth.svg.vec';
  final String solidHeart = 'assets/images/svgs/solid_heart.svg.vec';
  final String solidRobot = 'assets/images/svgs/solid_robot.svg.vec';
  final String solidFlag = 'assets/images/svgs/solid_flag.svg.vec';
  final String solidHappy = 'assets/images/svgs/solid_happy.svg.vec';
  final String solidMobile = 'assets/images/svgs/solid_mobile.svg.vec';
  final String maleIcon = 'assets/images/svgs/male_icon.svg.vec';
  final String femaleIcon = 'assets/images/svgs/female_icon.svg.vec';
  final String X = 'assets/images/svgs/X.svg.vec';
  final String wheelSelector = 'assets/images/svgs/wheel_selector.svg.vec';
  final String emoji1 = 'assets/images/svgs/emoji1.svg.vec';
  final String emoji2 = 'assets/images/svgs/emoji2.svg.vec';
  final String emoji3 = 'assets/images/svgs/emoji3.svg.vec';
  final String emoji4 = 'assets/images/svgs/emoji4.svg.vec';
  final String emoji5 = 'assets/images/svgs/emoji5.svg.vec';
  final String pointer = 'assets/images/svgs/pointer.svg.vec';
  final String yes = 'assets/images/svgs/yes.svg.vec';
  final String no = 'assets/images/svgs/no.svg.vec';
  final String sliderCenter = 'assets/images/svgs/slider_center.svg.vec';
  final String gridIcon1 = 'assets/images/svgs/grid_icon1.svg.vec';
  final String gridIcon2 = 'assets/images/svgs/grid_icon2.svg.vec';
  final String gridIcon3 = 'assets/images/svgs/grid_icon3.svg.vec';
  final String gridIcon4 = 'assets/images/svgs/grid_icon4.svg.vec';
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
  final String page11;
  final String page13;
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
    required this.page11,
    required this.page13,
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
    String? page11,
    String? page13,
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
      page11: page11 ?? this.page11,
      page13: page13 ?? this.page13,
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
      page11: other.page11,
      page13: other.page13,
    );
  }

  static const CustomAssets light = CustomAssets(
    icon: 'assets/images/svgs/light/icon.svg.vec',
    onboarding0: 'assets/images/svgs/light/onboarding_0.svg.vec',
    onboarding1: 'assets/images/svgs/light/onboarding_1.svg.vec',
    onboarding2: 'assets/images/svgs/light/onboarding_2.svg.vec',
    onboarding3: 'assets/images/svgs/light/onboarding_3.svg.vec',
    onboarding4: 'assets/images/svgs/light/onboarding_4.svg.vec',
    onboarding5: 'assets/images/svgs/light/onboarding_5.svg.vec',
    forgotPassword: 'assets/images/svgs/light/forgot_password.svg.vec',
    male: 'assets/images/svgs/light/male.svg.vec',
    female: 'assets/images/svgs/light/female.svg.vec',
    page6: 'assets/images/svgs/light/page6.svg.vec',
    page11: 'assets/images/svgs/light/page11.svg.vec',
    page13: 'assets/images/svgs/light/page13.svg.vec',
  );
  static const CustomAssets dark = CustomAssets(
    icon: 'assets/images/svgs/dark/icon.svg.vec',
    onboarding0: 'assets/images/svgs/dark/onboarding_0.svg.vec',
    onboarding1: 'assets/images/svgs/dark/onboarding_1.svg.vec',
    onboarding2: 'assets/images/svgs/dark/onboarding_2.svg.vec',
    onboarding3: 'assets/images/svgs/dark/onboarding_3.svg.vec',
    onboarding4: 'assets/images/svgs/dark/onboarding_4.svg.vec',
    onboarding5: 'assets/images/svgs/dark/onboarding_5.svg.vec',
    forgotPassword: 'assets/images/svgs/dark/forgot_password.svg.vec',
    male: 'assets/images/svgs/dark/male.svg.vec',
    female: 'assets/images/svgs/dark/female.svg.vec',
    page6: 'assets/images/svgs/dark/page6.svg.vec',
    page11: 'assets/images/svgs/dark/page11.svg.vec',
    page13: 'assets/images/svgs/dark/page13.svg.vec',
  );
}
