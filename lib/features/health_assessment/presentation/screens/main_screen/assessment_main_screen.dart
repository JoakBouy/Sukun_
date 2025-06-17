import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_app_bar.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/first_screen/assessment_first_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/count_card.dart';

class AssessmentMainScreen extends StatefulWidget {
  const AssessmentMainScreen({super.key});

  @override
  State<AssessmentMainScreen> createState() => _AssessmentMainScreenState();
}

class _AssessmentMainScreenState extends State<AssessmentMainScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: StringsManager.assessmentTitle,
        actions: [CountCard(count: _currentPage + 1)],
      ),
      body: PageView(
        controller: _pageController,
        children: [AssessmentFirstScreen(), Container()],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SizesManager.tPadding,
          horizontal: SizesManager.padding,
        ),
        child: CustomButton(
          text: StringsManager.continueButton,
          onPressed:
              () => {
                _pageController.animateToPage(
                  _currentPage + 1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                ),
                setState(() {
                  _currentPage <= 12 ? _currentPage += 1 : null;
                }),
              },
        ),
      ),
    );
  }
}
