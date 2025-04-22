import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playground/core/managers/assets_manager.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';
import 'package:playground/core/managers/strings_manager.dart';
import 'package:playground/core/managers/theme_manager.dart';
import 'package:playground/core/widgets/back_button.dart';
import 'package:playground/features/authentication/presentation/widgets/forgot_password_card.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final List<Choice> items = const [
    Choice(StringsManager.forgotPasswordListTitle1, AssetsManager.p_2fa),
    Choice(StringsManager.forgotPasswordListTitle2, AssetsManager.password),
    Choice(StringsManager.forgotPasswordListTitle3, AssetsManager.googleAuth),
  ];
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: SizesManager.padding),
              child: CustomBackButton(),
            ),
            Text(
              StringsManager.forgotPassword,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SizesManager.padding,
              ),
              child: Text(
                StringsManager.forgotPasswordSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:
                      () => setState(() {
                        selectedIndex = index;
                      }),
                  child: ForgotPasswordCard(
                    iconPath: items[index].icon,
                    title: items[index].title,
                    selected: selectedIndex == index,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SizesManager.padding,
              ),
              child: ElevatedButton(
                onPressed: () => {},
                style: ThemeManager.elevatedButtonStyle,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.sendPassword,
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
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice(this.title, this.icon);
  final String title;
  final String icon;
}
