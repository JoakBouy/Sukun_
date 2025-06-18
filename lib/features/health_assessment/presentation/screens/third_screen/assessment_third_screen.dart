import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class AssessmentThirdScreen extends StatefulWidget {
  const AssessmentThirdScreen({super.key});

  @override
  State<AssessmentThirdScreen> createState() => _AssessmentThirdScreenState();
}

class _AssessmentThirdScreenState extends State<AssessmentThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SizesManager.padding),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: []),
    );
  }
}
