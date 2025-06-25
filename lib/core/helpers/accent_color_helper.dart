import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class AccentColorHelper {
  static Color getColor(final int index, final ThemeData theme) {
    final List<Color> colors = [
      theme.extension<CustomColors>()!.green,
      theme.extension<CustomColors>()!.orange,
      theme.extension<CustomColors>()!.grey,
      theme.extension<CustomColors>()!.yellow,
      theme.extension<CustomColors>()!.violet,
    ];
    return colors[index];
  }

  static Color getAccentColor(final int index, final ThemeData theme) {
    final List<Color> accentColors = [
      theme.extension<CustomColors>()!.greenAccent,
      theme.extension<CustomColors>()!.orangeAccent,
      theme.extension<CustomColors>()!.greyAccent,
      theme.extension<CustomColors>()!.yellowAccent,
      theme.extension<CustomColors>()!.violetAccent,
    ];
    return accentColors[index];
  }
}
