import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/widgets/back_button.dart';

PreferredSizeWidget customAppBar({
  required ThemeData theme,
  required String title,
  List<Widget>? actions,
  double height = SizesManager.defaultAppBarHeight,
}) {
  return AppBar(
    forceMaterialTransparency: true,
    title: Row(
      children: [
        CustomBackButton(),
        Padding(
          padding: const EdgeInsets.all(SizesManager.padding),
          child: Text(
            title,
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
    toolbarHeight: height,
    actions: actions ?? [],
    automaticallyImplyLeading: false,
  );
}
