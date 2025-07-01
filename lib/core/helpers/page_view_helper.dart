import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/eighth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eleventh_page/eleventh_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/fifth_page/fifth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/first_page/first_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/fourteenth_page/fourteenth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/fourth_page/fourth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/ninth_page/ninth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/second_page/second_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/seventh_page/seventh_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/sixth_page/sixth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/tenth_page/tenth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/third_page/third_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/thirteenth_page/thirteenth_page.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/twelfth_page/twelfth_page.dart';

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
      case 5:
        return FifthPage();
      case 6:
        return SixthPage();
      case 7:
        return SeventhPage();
      case 8:
        return EighthPage();
      case 9:
        return NinthPage();
      case 10:
        return TenthPage();
      case 11:
        return EleventhPage();
      case 12:
        return TwelfthPage();
      case 13:
        return ThirteenthPage();
      case 14:
        return FourteenthPage();
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
