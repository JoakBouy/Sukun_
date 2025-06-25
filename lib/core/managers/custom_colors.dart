import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color primary;
  final Color lightPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onBackground;
  final Color background;
  final Color iconColor;
  final Color activeIconColor;
  final Color green = const Color(0xFF9BB168);
  final Color greenAccent;
  final Color orange = const Color(0xFFED7E1C);
  final Color orangeAccent;
  final Color grey = const Color(0xFF736B66);
  final Color greyAccent;
  final Color yellow = const Color(0xFFFFBD1A);
  final Color yellowAccent;
  final Color violet = const Color(0xFFA694F5);
  final Color violetAccent;

  const CustomColors({
    required this.primary,
    required this.lightPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onBackground,
    required this.background,
    required this.iconColor,
    required this.activeIconColor,
    required this.greenAccent,
    required this.orangeAccent,
    required this.greyAccent,
    required this.yellowAccent,
    required this.violetAccent,
  });

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? primary,
    Color? lightPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onBackground,
    Color? background,
    Color? iconColor,
    Color? activeIconColor,
    Color? greenAccent,
    Color? orangeAccent,
    Color? greyAccent,
    Color? yellowAccent,
    Color? violetAccent,
  }) => CustomColors(
    primary: primary ?? this.primary,
    lightPrimary: lightPrimary ?? this.lightPrimary,
    primaryContainer: primaryContainer ?? this.primaryContainer,
    onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
    secondary: secondary ?? this.secondary,
    onBackground: onBackground ?? this.onBackground,
    background: background ?? this.background,
    iconColor: iconColor ?? this.iconColor,
    activeIconColor: activeIconColor ?? this.activeIconColor,
    greenAccent: greenAccent ?? this.greenAccent,
    orangeAccent: orangeAccent ?? this.orangeAccent,
    greyAccent: greyAccent ?? this.greyAccent,
    yellowAccent: yellowAccent ?? this.yellowAccent,
    violetAccent: violetAccent ?? this.violetAccent,
  );

  @override
  ThemeExtension<CustomColors> lerp(
    ThemeExtension<CustomColors>? other,
    double t,
  ) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      primary: Color.lerp(primary, other.primary, t)!,
      lightPrimary: Color.lerp(lightPrimary, other.lightPrimary, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer:
          Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      background: Color.lerp(background, other.background, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      activeIconColor: Color.lerp(activeIconColor, other.activeIconColor, t)!,
      greenAccent: Color.lerp(greenAccent, other.greenAccent, t)!,
      orangeAccent: Color.lerp(orangeAccent, other.orangeAccent, t)!,
      greyAccent: Color.lerp(greyAccent, other.greyAccent, t)!,
      yellowAccent: Color.lerp(yellowAccent, other.yellowAccent, t)!,
      violetAccent: Color.lerp(violetAccent, other.violetAccent, t)!,
    );
  }

  static CustomColors light = const CustomColors(
    primary: Color(0xFF4F3422),
    lightPrimary: Color(0xFF926247),
    primaryContainer: Color(0xFFFFFFFF),
    onPrimaryContainer: Color(0xFF736B66),
    secondary: Color(0xFF9db068),
    onBackground: Color(0xFF4F3422),
    background: Color(0xFFF7F4F2),
    iconColor: Color(0xFFC9C7C5),
    activeIconColor: Color(0xFFFFFFFF),
    greenAccent: Color(0xFFE5EAD7),
    orangeAccent: Color(0xFFFFC89E),
    greyAccent: Color(0xFFE1E1E0),
    yellowAccent: Color(0xFFFFEBC2),
    violetAccent: Color(0xFFDDD1FF),
  );

  static CustomColors dark = const CustomColors(
    primary: Color(0xFF926247),
    lightPrimary: Color(0xFFC0A091),
    primaryContainer: Color(0xFF372315),
    onPrimaryContainer: Color(0xFFC9C7C5),
    secondary: Color(0xFF9db068),
    onBackground: Color(0xFFFFFFFF),
    background: Color(0xFF251404),
    iconColor: Color(0xFF736B66),
    activeIconColor: Color(0xFFFFFFFF),
    greenAccent: Color(0xFF3D4A26),
    orangeAccent: Color(0xFF663600),
    greyAccent: Color(0xFF3F3C36),
    yellowAccent: Color(0xFF705600),
    violetAccent: Color(0xFF3C357C),
  );
}
