import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_app_bar.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/count_card.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/radio_card.dart';

class AssessmentMainScreen extends StatelessWidget {
  const AssessmentMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int groupValue = 0;
    return Scaffold(
      appBar: customAppBar(
        context,
        title: StringsManager.assessmentTitle,
        actions: [CountCard(count: 1)],
      ),
      body: SingleChildScrollView(
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
              StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      RadioCard(
                        value: 1,
                        title: StringsManager.assessmentTitle1Radio1,
                        icon: AssetsManager.solidHeart,
                        groupValue: groupValue,
                        onChanged: (val) {
                          setState(() {
                            groupValue = val!;
                          });
                        },
                      ),
                      RadioCard(
                        value: 2,
                        title: StringsManager.assessmentTitle1Radio2,
                        icon: AssetsManager.solidRobot,
                        groupValue: groupValue,
                        onChanged: (val) {
                          setState(() {
                            groupValue = val!;
                          });
                        },
                      ),
                      RadioCard(
                        value: 3,
                        title: StringsManager.assessmentTitle1Radio3,
                        icon: AssetsManager.solidFlag,
                        groupValue: groupValue,
                        onChanged: (val) {
                          setState(() {
                            groupValue = val!;
                          });
                        },
                      ),
                      RadioCard(
                        value: 4,
                        title: StringsManager.assessmentTitle1Radio4,
                        icon: AssetsManager.solidHappy,
                        groupValue: groupValue,
                        onChanged: (val) {
                          setState(() {
                            groupValue = val!;
                          });
                        },
                      ),
                      RadioCard(
                        value: 5,
                        title: StringsManager.assessmentTitle1Radio5,
                        icon: AssetsManager.solidMobile,
                        groupValue: groupValue,
                        onChanged: (val) {
                          setState(() {
                            groupValue = val!;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SizesManager.tPadding,
          horizontal: SizesManager.padding,
        ),
        child: CustomButton(
          text: StringsManager.continueButton,
          onPressed: () {},
        ),
      ),
    );
  }
}
