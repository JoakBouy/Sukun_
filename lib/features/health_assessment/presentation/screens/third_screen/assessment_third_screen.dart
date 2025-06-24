import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/third_screen/widgets/age_widget.dart';

class AssessmentThirdScreen extends StatefulWidget {
  const AssessmentThirdScreen({super.key});

  @override
  State<AssessmentThirdScreen> createState() => _AssessmentThirdScreenState();
}

class _AssessmentThirdScreenState extends State<AssessmentThirdScreen> {
  final CarouselController _controller = CarouselController(initialItem: 17);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                StringsManager.assessmentTitle3,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: SizesManager.dhPadding),
              AgeWidget(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}
