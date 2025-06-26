import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/first_page/radio_card.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        children: [
          RadioCard(
            value: 1,
            title: StringsManager.assessmentTitle1Radio1,
            icon: theme.extension<CustomAssets>()!.solidHeart,
            groupValue: _groupValue,
            onChanged: (val) {
              setState(() {
                _groupValue = val!;
              });
            },
          ),
          RadioCard(
            value: 2,
            title: StringsManager.assessmentTitle1Radio2,
            icon: theme.extension<CustomAssets>()!.solidRobot,
            groupValue: _groupValue,
            onChanged: (val) {
              setState(() {
                _groupValue = val!;
              });
            },
          ),
          RadioCard(
            value: 3,
            title: StringsManager.assessmentTitle1Radio3,
            icon: theme.extension<CustomAssets>()!.solidFlag,
            groupValue: _groupValue,
            onChanged: (val) {
              setState(() {
                _groupValue = val!;
              });
            },
          ),
          RadioCard(
            value: 4,
            title: StringsManager.assessmentTitle1Radio4,
            icon: theme.extension<CustomAssets>()!.solidHappy,
            groupValue: _groupValue,
            onChanged: (val) {
              setState(() {
                _groupValue = val!;
              });
            },
          ),
          RadioCard(
            value: 5,
            title: StringsManager.assessmentTitle1Radio5,
            icon: theme.extension<CustomAssets>()!.solidMobile,
            groupValue: _groupValue,
            onChanged: (val) {
              setState(() {
                _groupValue = val!;
              });
            },
          ),
        ],
      ),
    );
  }
}
