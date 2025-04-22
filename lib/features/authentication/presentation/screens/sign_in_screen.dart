import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playground/core/managers/assets_manager.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/navigation_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';
import 'package:playground/core/managers/strings_manager.dart';
import 'package:playground/core/managers/theme_manager.dart';
import 'package:playground/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:playground/features/authentication/presentation/widgets/top_bar_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String isDarkMode;
  late final double height = MediaQuery.of(context).size.height;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            TopBar(),
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
                          StringsManager.authenticationTitle,
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
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
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
                        vertical: SizesManager.dPadding,
                      ),
                      child: ElevatedButton(
                        onPressed: () => submitForm(),
                        style: ThemeManager.elevatedButtonStyle,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringsManager.signIn,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(width: SizesManager.padding),
                            SvgPicture.asset(AssetsManager.arrow),
                          ],
                        ),
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
                      padding: const EdgeInsets.only(top: SizesManager.padding),
                      child: Center(
                        child: GestureDetector(
                          onTap:
                              () => Navigator.of(context).pushReplacementNamed(
                                NavigationManager.signUpScreen,
                              ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: StringsManager.noAccount,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  children: [
                                    TextSpan(
                                      text: StringsManager.signUp,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.copyWith(
                                        color: ColorsManager.orange,
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: SizesManager.hPadding,
                        ),
                        child: GestureDetector(
                          onTap:
                              () => Navigator.of(context).pushNamed(
                                NavigationManager.authenticationScreen,
                              ),
                          child: Text(
                            StringsManager.forgotPassword,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(
                              color: ColorsManager.orange,
                              decoration: TextDecoration.underline,
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
      ),
    );
  }
}
