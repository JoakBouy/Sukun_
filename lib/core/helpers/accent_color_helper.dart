import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class AccentColorHelper {
  static Color getColor(final int index, final BuildContext context) {
    final List<Color> colors = [
      Theme.of(context).extension<CustomColors>()!.green,
      Theme.of(context).extension<CustomColors>()!.orange,
      Theme.of(context).extension<CustomColors>()!.grey,
      Theme.of(context).extension<CustomColors>()!.yellow,
      Theme.of(context).extension<CustomColors>()!.violet,
    ];
    return colors[index];
  }

  static Color getAccentColor(final int index, final BuildContext context) {
    final List<Color> accentColors = [
      Theme.of(context).extension<CustomColors>()!.greenAccent,
      Theme.of(context).extension<CustomColors>()!.orangeAccent,
      Theme.of(context).extension<CustomColors>()!.greyAccent,
      Theme.of(context).extension<CustomColors>()!.yellowAccent,
      Theme.of(context).extension<CustomColors>()!.violetAccent,
    ];
    return accentColors[index];
  }
}
