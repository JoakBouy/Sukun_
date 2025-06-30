import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:vector_graphics/vector_graphics.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: AlertDialog(
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
            backgroundColor: theme.colorScheme.primaryContainer,
            title: SvgPicture(
              AssetBytesLoader(theme.extension<CustomAssets>()!.forgotPassword),
              width: 308,
              height: 248,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    StringsManager.forgetPasswordPopup1,
                    style: theme.textTheme.titleSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: SizesManager.padding),
                    child: Text(
                      StringsManager.forgetPasswordPopup2,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CustomButton(
                text: StringsManager.resendPassword,
                icon: theme.extension<CustomAssets>()!.lock,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: SizesManager.hPadding),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(20),
            ),
            child: SizedBox(
              child: Icon(
                Icons.close,
                color: theme.colorScheme.primary,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
