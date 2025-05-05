import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_app_bar.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/count_card.dart';

class AssessmentMainScreen extends StatelessWidget {
  const AssessmentMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: StringsManager.assessmentTitle,
        actions: [CountCard(count: 1)],
      ),
    );
  }
}
