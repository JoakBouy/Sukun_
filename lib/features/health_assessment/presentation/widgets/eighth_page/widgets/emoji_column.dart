import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/helpers/widgets_helper.dart';
import 'package:vector_graphics/vector_graphics.dart';

class EmojiColumn extends StatelessWidget {
  const EmojiColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> emojis = WidgetsHelper.getEmojis(Theme.of(context));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            5,
            (index) => SvgPicture(
              AssetBytesLoader(emojis[index]),
              height: 48,
              width: 48,
            ),
          ),
        ],
      ),
    );
  }
}
