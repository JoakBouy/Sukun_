import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/back_button.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/authentication/presentation/widgets/forgot_password_card.dart';
import 'package:freud_ai/features/authentication/presentation/widgets/popup_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<Choice> items = [
      Choice(
        StringsManager.forgotPasswordListTitle1,
        theme.extension<CustomAssets>()!.p_2fa,
      ),
      Choice(
        StringsManager.forgotPasswordListTitle2,
        theme.extension<CustomAssets>()!.password,
      ),
      Choice(
        StringsManager.forgotPasswordListTitle3,
        theme.extension<CustomAssets>()!.googleAuth,
      ),
    ];
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
          child: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 600,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: SizesManager.padding,
                        ),
                        child: CustomBackButton(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 600,
                    child: Text(
                      StringsManager.forgotPassword,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    width: 600,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: SizesManager.padding,
                      ),
                      child: Text(
                        StringsManager.forgotPasswordSubtitle,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: SizesManager.tinyPadding,
                          ),
                          child: GestureDetector(
                            onTap:
                                () => setState(() {
                                  selectedIndex = index;
                                }),
                            child: ForgotPasswordCard(
                              iconPath: items[index].icon,
                              title: items[index].title,
                              selected: selectedIndex == index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
          child: CustomButton(
            text: StringsManager.sendPassword,
            icon: theme.extension<CustomAssets>()!.lock,
            onPressed:
                () => showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return const PopupWidget();
                  },
                ),
          ),
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
