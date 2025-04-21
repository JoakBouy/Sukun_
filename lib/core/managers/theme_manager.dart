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
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
      displaySmall: displaySmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primary, // Your custom dark theme color
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: ColorsManager.primaryLight,
    scaffoldBackgroundColor: ColorsManager.backgroundDark,
    textTheme: TextTheme(
      titleLarge: titleTheme,
      titleMedium: subtitleTheme.copyWith(color: ColorsManager.secondaryLight),
      bodySmall: smallTextTheme.copyWith(color: ColorsManager.onBackground),
      labelLarge: labelLarge.copyWith(color: ColorsManager.onBackground),
      labelMedium: labelMedium.copyWith(color: ColorsManager.white),
      labelSmall: labelSmall.copyWith(color: ColorsManager.white),
      displaySmall: displaySmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            ColorsManager.primaryLight, // Your custom dark theme color
      ),
    ),
  );
  static const TextStyle titleTheme = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.title,
  );
  static const TextStyle subtitleTheme = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: SizesManager.subTitle,
    color: ColorsManager.secondary,
  );
  static const TextStyle displaySmall = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.buttonText,
    color: ColorsManager.white,
  );
  static const TextStyle smallTextTheme = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: SizesManager.smallText,
    color: ColorsManager.secondary,
  );
  static const TextStyle labelLarge = TextStyle(
    fontFamily: StringsManager.fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.subTitle,
    color: ColorsManager.secondary,
  );
  static const TextStyle labelMedium = TextStyle(
    fontFamily: StringsManager.fontFamily,
    color: ColorsManager.primary,
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.smallText2,
  );
  static const TextStyle labelSmall = TextStyle(
    fontFamily: StringsManager.fontFamily,
    color: ColorsManager.primary,
    fontWeight: FontWeight.w900,
    fontSize: SizesManager.smallText,
  );
  static ButtonStyle outlinedButtonLightStyle = OutlinedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    side: const BorderSide(width: 1.2, color: ColorsManager.primary),
  );
  static ButtonStyle outlinedButtonDarkStyle = outlinedButtonLightStyle
      .copyWith(
        side: WidgetStateProperty.all(
          const BorderSide(width: 1.2, color: ColorsManager.white),
        ),
      );
  static ButtonStyle circularOutlinedButtonLightStyle =
      OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        side: const BorderSide(width: 1.2, color: ColorsManager.onBackground),
      );
  static ButtonStyle circularOutlinedButtonDarkStyle =
      circularOutlinedButtonLightStyle.copyWith(
        side: WidgetStateProperty.all(
          const BorderSide(width: 1.2, color: ColorsManager.white),
        ),
      );
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: ColorsManager.white,
    padding: const EdgeInsets.symmetric(
      vertical: SizesManager.padding,
      horizontal: SizesManager.dPadding,
    ),
  );
  static ButtonStyle circularElevatedButtonStyle = elevatedButtonStyle.copyWith(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(
        vertical: SizesManager.dPadding,
        horizontal: SizesManager.dPadding,
      ),
    ),
  );
}
