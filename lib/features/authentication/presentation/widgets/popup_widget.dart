import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playground/core/managers/assets_manager.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';
import 'package:playground/core/managers/strings_manager.dart';
import 'package:playground/core/managers/theme_manager.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? 'dark' : 'light';
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: SizesManager.hPadding),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: ColorsManager.white,
              padding: EdgeInsets.all(20),
            ),
            child: SizedBox(
              child: Icon(Icons.close, color: ColorsManager.primary, size: 32),
            ),
          ),
        ),
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
          ),
          contentPadding: EdgeInsets.all(SizesManager.padding),
          actionsPadding: EdgeInsets.all(SizesManager.padding),
          titlePadding: EdgeInsets.symmetric(
            horizontal: SizesManager.padding,
            vertical: SizesManager.padding - 4,
          ),
          backgroundColor:
              isDarkMode == 'dark'
                  ? ColorsManager.onBackgroundDark
                  : ColorsManager.white,
          title: SvgPicture.asset(AssetsManager.forgotPassword(isDarkMode)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  StringsManager.forgetPasswordPopup1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: SizesManager.padding),
                  child: Text(
                    StringsManager.forgetPasswordPopup2,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ThemeManager.elevatedButtonStyle,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringsManager.resendPassword,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(width: SizesManager.padding),
                  SvgPicture.asset(
                    AssetsManager.lock,
                    colorFilter: ColorFilter.mode(
                      ColorsManager.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
