import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class TextFieldTitleWidget extends StatelessWidget {
  const TextFieldTitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizesManager.hPadding),
          child: Text(title, style: Theme.of(context).textTheme.labelSmall),
        ),
      ),
    );
  }
}
