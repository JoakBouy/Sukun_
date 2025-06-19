import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';
import 'package:freud_ai/core/managers/colors_manager.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:freud_ai/features/authentication/presentation/widgets/top_bar_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String isDarkMode;
  late final double height = MediaQuery.of(context).size.height;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConformationController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? 'dark'
            : 'light';
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
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SizesManager.padding,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.25,
                              bottom: SizesManager.dPadding,
                            ),
                            child: Text(
                              StringsManager.authenticationTitle2,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizesManager.hPadding,
                          ),
                          child: Text(
                            StringsManager.email,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        CustomTextField(
                          controller: emailController,
                          iconPath: AssetsManager.email,
                          hintText: StringsManager.email2,
                          isDarkMode: isDarkMode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!RegExp(
                              r'\S+@\S+\.\S+',
                            ).hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: SizesManager.hPadding,
                          ),
                          child: Text(
                            StringsManager.password,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: StringsManager.password2,
                          iconPath: AssetsManager.lock,
                          isDarkMode: isDarkMode,
                          isObscure: true,
                          leadingIcon: AssetsManager.eye,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: SizesManager.hPadding,
                          ),
                          child: Text(
                            StringsManager.confirmPassword,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        CustomTextField(
                          controller: passwordConformationController,
                          hintText: StringsManager.confirmPassword2,
                          iconPath: AssetsManager.lock,
                          isDarkMode: isDarkMode,
                          isObscure: true,
                          leadingIcon: AssetsManager.eye,
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
                              OutlinedButton(
                                onPressed: () {},
                                style: ThemeManager.circularOutlinedButtonStyle,
                                child: SvgPicture.asset(
                                  AssetsManager.facebook,
                                  colorFilter: ColorFilter.mode(
                                    isDarkMode == 'dark'
                                        ? ColorsManager.white
                                        : ColorsManager.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                style: ThemeManager.circularOutlinedButtonStyle,
                                child: SvgPicture.asset(
                                  AssetsManager.google,
                                  colorFilter: ColorFilter.mode(
                                    isDarkMode == 'dark'
                                        ? ColorsManager.white
                                        : ColorsManager.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                style: ThemeManager.circularOutlinedButtonStyle,
                                child: SvgPicture.asset(
                                  AssetsManager.instagram,
                                  colorFilter: ColorFilter.mode(
                                    isDarkMode == 'dark'
                                        ? ColorsManager.white
                                        : ColorsManager.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: SizesManager.padding,
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap:
                                  () => Navigator.of(
                                    context,
                                  ).pushReplacementNamed(
                                    NavigationManager.authenticationScreen,
                                  ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: StringsManager.alreadyHaveAnAccount,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      children: [
                                        TextSpan(
                                          text: StringsManager.signIn,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall!.copyWith(
                                            color: ColorsManager.orange,
                                            decoration:
                                                TextDecoration.underline,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 180, child: TopBar()),
          ],
        ),
      ),
    );
  }
}
