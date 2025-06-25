import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_app_bar.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/first_screen/assessment_first_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/second_screen/assessment_second_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/third_screen/assessment_third_screen.dart';
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
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          AssessmentFirstScreen(),
          AssessmentSecondScreen(),
          AssessmentThirdScreen(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_currentPage == 1)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SizesManager.padding,
                  ),
                  child: CustomButton(
                    text: StringsManager.assessment2SkipButton,
                    icon: Theme.of(context).extension<CustomAssets>()!.X,
                    color: Theme.of(context).extension<CustomColors>()!.green,
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
              CustomButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
