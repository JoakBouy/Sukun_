import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/widgets/custom_slider.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/widgets/custom_vertical_slider.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/widgets/emoji_column.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/widgets/sleep_time_column.dart';

class EighthPage extends StatefulWidget {
  const EighthPage({super.key});

  @override
  State<EighthPage> createState() => _EighthPageState();
}

class _EighthPageState extends State<EighthPage> {
  double _value = 2.0;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      height: 400,
      width: 600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SleepTimeColumn(value: _value),
          CustomVerticalSlider(
            theme: theme,
            onChanged: (double value) => setState(() => _value = value),
            value: _value,
          ),
          EmojiColumn(),
        ],
      ),
    );
  }
}
