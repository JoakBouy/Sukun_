import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:vector_graphics/vector_graphics.dart';

class SixthPage extends StatelessWidget {
  const SixthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture(
        AssetBytesLoader(Theme.of(context).extension<CustomAssets>()!.page6),
        width: 286,
        height: 286,
      ),
    );
  }
}
