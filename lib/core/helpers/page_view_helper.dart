import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/page_view_screen/widgets/first_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/page_view_screen/widgets/second_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/page_view_screen/widgets/third_page.dart';

class PageViewHelper {
  static getPage(final int index) {
    switch (index) {
      case 0:
        return FirstPage();
      case 1:
        return SecondPage();
      case 2:
        return ThirdPage();
      default:
        return FirstPage();
    }
  }

  static getTitle(final int index) {
    switch (index) {
      case 0:
        return StringsManager.assessmentTitle1;
      case 1:
        return StringsManager.assessmentTitle2;
      case 2:
        return StringsManager.assessmentTitle3;
      default:
        return StringsManager.assessmentTitle1;
    }
  }
}
