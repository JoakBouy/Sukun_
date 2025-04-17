import 'package:flutter/material.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';
import 'package:playground/core/managers/strings_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.primary),
    scaffoldBackgroundColor: ColorsManager.backgroundLight,
    textTheme: TextTheme(
      titleLarge: titleTheme.copyWith(color: ColorsManager.primary),
      titleMedium: subtitleTheme,
      bodySmall: smallTextTheme,
      labelMedium: buttonTextTheme,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: ColorsManager.primary,
    scaffoldBackgroundColor: ColorsManager.backgroundDark,
    textTheme: TextTheme(
      titleLarge: titleTheme,
      titleMedium: subtitleTheme.copyWith(color: ColorsManager.secondaryLight),
      bodySmall: smallTextTheme.copyWith(color: ColorsManager.secondaryLight),
      labelMedium: buttonTextTheme,
    ),
  );
  static const titleTheme = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.title,
  );
  static const subtitleTheme = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: SizesManager.subTitle,
    color: ColorsManager.secondary,
  );
  static const buttonTextTheme = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.buttonText,
    color: ColorsManager.white,
  );
  static const smallTextTheme = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.smallText,
    color: ColorsManager.secondary,
  );
}
