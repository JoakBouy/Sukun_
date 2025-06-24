import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/radio_card.dart';

class AssessmentFirstScreen extends StatefulWidget {
  const AssessmentFirstScreen({super.key});

  @override
  State<AssessmentFirstScreen> createState() => _AssessmentFirstScreenState();
}

class _AssessmentFirstScreenState extends State<AssessmentFirstScreen> {
  int _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesManager.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                StringsManager.assessmentTitle1,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: SizesManager.dhPadding),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    RadioCard(
                      value: 1,
                      title: StringsManager.assessmentTitle1Radio1,
                      icon: AssetsManager.solidHeart,
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
                      icon: AssetsManager.solidRobot,
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
                      icon: AssetsManager.solidFlag,
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
                      icon: AssetsManager.solidHappy,
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
                      icon: AssetsManager.solidMobile,
                      groupValue: _groupValue,
                      onChanged: (val) {
                        setState(() {
                          _groupValue = val!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
