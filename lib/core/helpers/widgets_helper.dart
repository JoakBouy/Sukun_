import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class WidgetsHelper {
  static getPressedButtonTheme(ThemeData theme) => ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: theme.extension<CustomColors>()!.orange,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(200),
      side: BorderSide(
        color: theme.extension<CustomColors>()!.orangeAccent,
        width: 4,
      ),
    ),
  );

  static getUnselectedButtonTheme(ThemeData theme) => ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: theme.extension<CustomColors>()!.orange,
    shadowColor: Colors.transparent,
  );

  // background colors
  static List<Color> getEmojisColors(ThemeData theme) => [
    theme.extension<CustomColors>()!.green,
    Color.fromRGBO(252, 208, 100, 1),
    Color.fromRGBO(188, 160, 145, 1),
    theme.extension<CustomColors>()!.orange,
    theme.extension<CustomColors>()!.violet,
  ];
  // the faces of the wheel
  static List<String> getEmojis(ThemeData theme) => [
    theme.extension<CustomAssets>()!.emoji1,
    theme.extension<CustomAssets>()!.emoji2,
    theme.extension<CustomAssets>()!.emoji3,
    theme.extension<CustomAssets>()!.emoji4,
    theme.extension<CustomAssets>()!.emoji5,
  ];
  // the faces of the wheel
  static List<String> getEmojisStatue() => [
    "Awesome",
    "Good",
    "Natural",
    "Bad",
    "Terrible",
  ];
}
