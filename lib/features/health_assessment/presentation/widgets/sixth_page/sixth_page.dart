import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';

class SixthPage extends StatelessWidget {
  const SixthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        width: 286,
        height: 286,
        Theme.of(context).extension<CustomAssets>()!.page6,
      ),
    );
  }
}
