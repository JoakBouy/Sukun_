import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/page_view_screen/widgets/first_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/page_view_screen/widgets/fourth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/page_view_screen/widgets/second_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/screens/page_view_screen/widgets/third_page.dart';

class PageViewHelper {
  static getPage(final int index) {
    switch (index) {
      case 1:
        return FirstPage();
      case 2:
        return SecondPage();
      case 3:
        return ThirdPage();
      case 4:
        return FourthPage();
      default:
        return FirstPage();
    }
  }

  static getTitle(final int index) {
    switch (index) {
      case 1:
        return StringsManager.assessmentTitle1;
      case 2:
        return StringsManager.assessmentTitle2;
      case 3:
        return StringsManager.assessmentTitle3;
      case 4:
        return StringsManager.assessmentTitle4;
      case 5:
        return StringsManager.assessmentTitle5;
      case 6:
        return StringsManager.assessmentTitle6;
      case 7:
        return StringsManager.assessmentTitle7;
      case 8:
        return StringsManager.assessmentTitle8;
      case 9:
        return StringsManager.assessmentTitle9;
      case 10:
        return StringsManager.assessmentTitle10;
      case 11:
        return StringsManager.assessmentTitle11;
      case 12:
        return StringsManager.assessmentTitle12;
      case 13:
        return StringsManager.assessmentTitle13;
      case 14:
        return StringsManager.assessmentTitle14;
      default:
        return StringsManager.assessmentTitle1;
    }
  }
}
