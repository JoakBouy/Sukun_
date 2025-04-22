import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/colors_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.primary),
    scaffoldBackgroundColor: ColorsManager.backgroundLight,
    fontFamily: StringsManager.fontFamily,
    textTheme: TextTheme(
      titleLarge: titleTheme.copyWith(color: ColorsManager.primary),
      titleMedium: subtitleTheme,
      titleSmall: titleSmallTheme,
      bodySmall: smallTextTheme,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.primary, // Your custom dark theme color
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ColorsManager.onBackground),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: ColorsManager.primaryLight,
    scaffoldBackgroundColor: ColorsManager.backgroundDark,
    fontFamily: StringsManager.fontFamily,
    textTheme: TextTheme(
      titleLarge: titleTheme,
      titleMedium: subtitleTheme.copyWith(color: ColorsManager.secondaryLight),
      titleSmall: titleSmallTheme.copyWith(color: ColorsManager.white),
      bodySmall: smallTextTheme.copyWith(color: ColorsManager.onBackground),
      labelLarge: labelLarge.copyWith(color: ColorsManager.onBackground),
      labelMedium: labelMedium.copyWith(color: ColorsManager.white),
      labelSmall: labelSmall.copyWith(color: ColorsManager.white),
      displayMedium: displayMedium.copyWith(color: ColorsManager.white),
      displaySmall: displaySmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorsManager.white,
        backgroundColor:
            ColorsManager.primaryLight, // Your custom dark theme color
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 1.4, color: ColorsManager.white),
      ),
    ),
  );
  static const TextStyle titleTheme = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.title,
  );
  static const TextStyle titleSmallTheme = TextStyle(
    color: ColorsManager.primary,
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.titleSmall,
  );
  static const TextStyle subtitleTheme = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizesManager.subTitle,
    color: ColorsManager.secondary,
  );
  static const TextStyle displayMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.displayMedium,
    color: ColorsManager.primary,
  );
  static const TextStyle displaySmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.buttonText,
    color: ColorsManager.white,
  );
  static const TextStyle smallTextTheme = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.smallText,
    color: ColorsManager.secondary,
  );
  static const TextStyle labelLarge = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.subTitle,
    color: ColorsManager.secondary,
  );
  static const TextStyle labelMedium = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.smallText2,
    color: ColorsManager.primary,
  );
  static const TextStyle labelSmall = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: SizesManager.smallText,
    color: ColorsManager.primary,
  );
  static ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );
  static ButtonStyle circularOutlinedButtonStyle = outlinedButtonStyle.copyWith(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ),
  );
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
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
