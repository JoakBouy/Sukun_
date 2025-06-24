import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/second_screen/widgets/gender_card_widget.dart';

class AssessmentSecondScreen extends StatefulWidget {
  const AssessmentSecondScreen({super.key});

  @override
  State<AssessmentSecondScreen> createState() => _AssessmentSecondScreenState();
}

class _AssessmentSecondScreenState extends State<AssessmentSecondScreen> {
  int _selectedValue = 0;

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
                StringsManager.assessmentTitle2,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: SizesManager.dhPadding),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _selectedValue = 1),
                      child: GenderCardWidget(
                        isSelected: _selectedValue == 1,
                        isMale: true,
                      ),
                    ),
                    const SizedBox(height: SizesManager.hPadding),
                    GestureDetector(
                      onTap: () => setState(() => _selectedValue = 2),
                      child: GenderCardWidget(
                        isSelected: _selectedValue == 2,
                        isMale: false,
                      ),
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
