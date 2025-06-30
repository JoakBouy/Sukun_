import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/authentication/presentation/widgets/custom_outlined_button.dart';
import 'package:freud_ai/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:freud_ai/features/authentication/presentation/widgets/text_field_title_widget.dart';
import 'package:freud_ai/features/authentication/presentation/widgets/top_bar_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConformationController = TextEditingController();

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConformationController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Welcome Back')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Something Went Wrong ')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizesManager.padding,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 220,
                          bottom: SizesManager.dPadding,
                        ),
                        child: Text(
                          StringsManager.authenticationTitle2,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    TextFieldTitleWidget(title: StringsManager.email),
                    CustomTextField(
                      controller: emailController,
                      iconPath: theme.extension<CustomAssets>()!.email,
                      hintText: StringsManager.email2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    TextFieldTitleWidget(title: StringsManager.password),
                    CustomTextField(
                      controller: passwordController,
                      hintText: StringsManager.password2,
                      iconPath: theme.extension<CustomAssets>()!.lock,
                      isObscure: true,
                      leadingIcon: theme.extension<CustomAssets>()!.eye,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    TextFieldTitleWidget(title: StringsManager.password2),
                    CustomTextField(
                      controller: passwordConformationController,
                      hintText: StringsManager.confirmPassword2,
                      iconPath: theme.extension<CustomAssets>()!.lock,
                      isObscure: true,
                      leadingIcon: theme.extension<CustomAssets>()!.eye,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Conformation is required';
                        } else if (passwordController.text !=
                            passwordConformationController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: SizesManager.dPadding,
                      ),
                      child: CustomButton(
                        text: StringsManager.signUp,
                        onPressed: () => submitForm(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: SizesManager.padding,
                      ),
                      child: Row(
                        spacing: SizesManager.padding,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomOutlinedButton(
                            icon: theme.extension<CustomAssets>()!.facebook,
                            theme: theme,
                          ),
                          CustomOutlinedButton(
                            icon: theme.extension<CustomAssets>()!.google,
                            theme: theme,
                          ),
                          CustomOutlinedButton(
                            icon: theme.extension<CustomAssets>()!.instagram,
                            theme: theme,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: SizesManager.padding),
                      child: Center(
                        child: GestureDetector(
                          onTap:
                              () => Navigator.of(context).pushReplacementNamed(
                                NavigationManager.authenticationScreen,
                              ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: StringsManager.alreadyHaveAnAccount,
                                  style: theme.textTheme.bodySmall,
                                  children: [
                                    TextSpan(
                                      text: StringsManager.signIn,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).extension<CustomColors>()!.orange,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            SizedBox(height: 180, child: TopBar()),
          ],
        ),
      ),
    );
  }
}
