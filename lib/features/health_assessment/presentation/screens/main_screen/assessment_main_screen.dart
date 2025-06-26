import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_app_bar.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/page_view_screen/page_view_screen.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/count_card.dart';

class AssessmentMainScreen extends StatefulWidget {
  const AssessmentMainScreen({super.key});

  @override
  State<AssessmentMainScreen> createState() => _AssessmentMainScreenState();
}

class _AssessmentMainScreenState extends State<AssessmentMainScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBar(
        theme: theme,
        title: StringsManager.assessmentTitle,
        actions: [CountCard(count: _currentPage)],
      ),
      body: PageView(
        key: Key(_currentPage.toString()),
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [PageViewScreen(index: _currentPage)],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_currentPage == 2)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SizesManager.padding,
                  ),
                  child: CustomButton(
                    text: StringsManager.assessment2SkipButton,
                    icon: theme.extension<CustomAssets>()!.X,
                    color: theme.extension<CustomColors>()!.green,
                    onPressed:
                        () => {
                          _pageController.animateToPage(
                            _currentPage + 1,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          ),
                          setState(() {
                            _currentPage < 14 ? _currentPage += 1 : null;
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
                        //_currentPage + 1 < 14 ? _currentPage += 1 : null;

                        // limit to currently implemented pages (5)
                        _currentPage < 5 ? _currentPage += 1 : null;
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
