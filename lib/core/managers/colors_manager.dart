import 'package:flutter/material.dart';

class ColorsManager {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color primary = Color(0xFF4F3422);
  static const Color primaryLight = Color(0xFF926247);
  static const Color secondary = Color(0xFF736B66);
  static const Color secondaryLight = Color(0xFFE8DDD9);
  static const Color backgroundLight = Color(0xFFF7F4F2);
  static const Color backgroundDark = Color(0xFF251404);
  static const Color green = Color(0xFF9BB168);
  static const Color lightGreen = Color(0xFFE5EAD7);
  static const Color darkGreen = Color(0xFF3D4A26);
  static const Color orange = Color(0xFFED7E1C);
  static const Color lightOrange = Color(0xFFFFC89E);
  static const Color darkOrange = Color(0xFF663600);
  static const Color grey = Color(0xFF736B66);
  static const Color lightGrey = Color(0xFFE1E1E0);
  static const Color darkGrey = Color(0xFF3F3C36);
  static const Color yellow = Color(0xFFFFBD1A);
  static const Color lightYellow = Color(0xFFFFEBC2);
  static const Color darkYellow = Color(0xFF705600);
  static const Color violet = Color(0xFFA694F5);
  static const Color lightViolet = Color(0xFFDDD1FF);
  static const Color darkViolet = Color(0xFF3C357C);

  static Color getAccentColor(int index) {
    switch (index) {
      case 1:
        return green;
      case 2:
        return orange;
      case 3:
        return grey;
      case 4:
        return yellow;
      case 5:
        return violet;
      default:
        return primary;
    }
  }

  static Color getBackgroundColor(int index, String isDarkMode) {
    switch (index) {
      case 1:
        return isDarkMode == 'dark' ? darkGreen : lightGreen;
      case 2:
        return isDarkMode == 'dark' ? darkOrange : lightOrange;
      case 3:
        return isDarkMode == 'dark' ? darkGrey : lightGrey;
      case 4:
        return isDarkMode == 'dark' ? darkYellow : lightYellow;
      case 5:
        return isDarkMode == 'dark' ? darkViolet : lightViolet;
      default:
        return isDarkMode == 'dark' ? backgroundDark : backgroundLight;
    }
  }
}
