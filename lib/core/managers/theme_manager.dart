import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';

class ThemeManager {
  // Light Theme data
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: CustomColors.light().primary,
      secondary: CustomColors.light().secondary,
      primaryContainer: CustomColors.light().primaryContainer,
      onPrimaryContainer: CustomColors.light().onPrimaryContainer,
      surface: CustomColors.light().background,
      onSurface: CustomColors.light().onBackground,
    ),
    scaffoldBackgroundColor: CustomColors.light().background,
    fontFamily: StringsManager.fontFamily,
    textTheme: TextTheme(
      titleLarge: titleTheme.copyWith(color: CustomColors.light().primary),
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
        foregroundColor: CustomColors.light().primaryContainer,
        backgroundColor: CustomColors.light().primary,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: CustomColors.light().onBackground),
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[CustomColors.light()],
  );

  // Dark Theme data
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: CustomColors.dark().primary,
      secondary: CustomColors.dark().secondary,
      primaryContainer: CustomColors.dark().primaryContainer,
      onPrimaryContainer: CustomColors.dark().onPrimaryContainer,
      surface: CustomColors.dark().background,
      onSurface: CustomColors.dark().onBackground,
    ),
    scaffoldBackgroundColor: CustomColors.dark().background,
    fontFamily: StringsManager.fontFamily,
    textTheme: TextTheme(
      titleLarge: titleTheme,
      titleMedium: subtitleTheme.copyWith(
        color: CustomColors.dark().onBackground,
      ),
      titleSmall: titleSmallTheme.copyWith(
        color: CustomColors.dark().onBackground,
      ),
      bodySmall: smallTextTheme.copyWith(
        color: CustomColors.dark().onPrimaryContainer,
      ),
      labelLarge: labelLarge.copyWith(
        color: CustomColors.dark().onPrimaryContainer,
      ),
      labelMedium: labelMedium.copyWith(
        color: CustomColors.dark().onBackground,
      ),
      labelSmall: labelSmall.copyWith(color: CustomColors.dark().onBackground),
      displayMedium: displayMedium.copyWith(
        color: CustomColors.dark().onBackground,
      ),
      displaySmall: displaySmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: CustomColors.dark().onBackground,
        backgroundColor: CustomColors.dark().primary,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1.4, color: CustomColors.dark().onBackground),
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[CustomColors.dark()],
  );

  // Text Styles
  static const TextStyle titleTheme = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.title,
  );
  static TextStyle titleSmallTheme = TextStyle(
    color: CustomColors.light().primary,
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.titleSmall,
  );
  static TextStyle subtitleTheme = TextStyle(
    color: CustomColors.light().onPrimaryContainer,
    fontWeight: FontWeight.w500,
    fontSize: SizesManager.subTitle,
  );
  static TextStyle displayMedium = TextStyle(
    color: CustomColors.light().primary,
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.displayMedium,
  );
  static TextStyle displaySmall = TextStyle(
    color: CustomColors.light().primaryContainer,
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.buttonText,
  );
  static TextStyle smallTextTheme = TextStyle(
    color: CustomColors.light().onPrimaryContainer,
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.smallText,
  );
  static TextStyle labelLarge = TextStyle(
    color: CustomColors.light().onPrimaryContainer,
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.subTitle - 1,
  );
  static TextStyle labelMedium = TextStyle(
    color: CustomColors.light().onBackground,
    fontWeight: FontWeight.w700,
    fontSize: SizesManager.smallText2,
  );
  static TextStyle labelSmall = TextStyle(
    color: CustomColors.light().onBackground,
    fontWeight: FontWeight.w800,
    fontSize: SizesManager.smallText,
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
