import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class AlphabeticalBar extends StatelessWidget {
  const AlphabeticalBar({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      fontSize: SizesManager.font14,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onPrimaryContainer,
    );
    return Card(
      color: theme.extension<CustomColors>()!.greyAccent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.transparent,
          width: 0,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(
          SizesManager.cardCircularBorderRadius,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AlphabeticalButton(letter: 'A', style: style),
          AlphabeticalButton(letter: 'B', style: style),
          AlphabeticalButton(letter: 'C', style: style),
          AlphabeticalButton(letter: '...', style: style),
          AlphabeticalButton(letter: 'X', style: style),
          AlphabeticalButton(letter: 'Y', style: style),
          AlphabeticalButton(letter: 'Z', style: style),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: theme.colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class AlphabeticalButton extends StatelessWidget {
  const AlphabeticalButton({
    super.key,
    required this.style,
    required this.letter,
  });
  final TextStyle style;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        SizesManager.cardCircularBorderRadius,
      ),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizesManager.cardCircularBorderRadius,
          ),
        ),
        width: 40,
        height: 40,
        child: Center(child: Text(letter, style: style)),
      ),
    );
  }
}
