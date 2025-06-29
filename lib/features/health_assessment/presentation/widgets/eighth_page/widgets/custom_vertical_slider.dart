import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/widgets/custom_slider.dart';

class CustomVerticalSlider extends StatelessWidget {
  final ThemeData theme;
  final void Function(double) onChanged;
  final double value;
  const CustomVerticalSlider({
    super.key,
    required this.theme,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: CustomSlider(
        activeTrackColor: Color(0xffc0610a),
        trackColor: theme.colorScheme.primary.withAlpha(80),
        divisions: 4,
        divisionColor: Colors.transparent,
        min: 0,
        max: 4,
        thumb: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.extension<CustomColors>()!.orange,
              border: Border.all(
                strokeAlign: BorderSide.strokeAlignOutside,
                color: theme.extension<CustomColors>()!.orangeAccent.withAlpha(
                  120,
                ),
                width: 4,
              ),
            ),
            child: SvgPicture.asset(
              fit: BoxFit.scaleDown,
              width: 24,
              height: 24,
              theme.extension<CustomAssets>()!.sliderCenter,
            ),
          ),
        ),
        trackHeight: 14,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
