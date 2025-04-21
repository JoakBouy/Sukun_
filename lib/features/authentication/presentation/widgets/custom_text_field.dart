import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playground/core/managers/colors_manager.dart';
import 'package:playground/core/managers/sizes_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final String iconPath;
  final bool? isObscure;
  final String? leadingIcon;
  final String isDarkMode;
  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    required this.iconPath,
    this.isObscure,
    this.leadingIcon,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ColorsManager.green,
      cursorWidth: 3.0,
      cursorHeight: 16.0,
      cursorOpacityAnimates: true,
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        suffixIcon:
            leadingIcon != null
                ? Padding(
                  padding: const EdgeInsets.only(right: SizesManager.hPadding),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      leadingIcon!,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                        isDarkMode == 'dark'
                            ? ColorsManager.iconDark
                            : ColorsManager.onBackground,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
                : null,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: SizesManager.hPadding),
          child: SvgPicture.asset(
            iconPath,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              isDarkMode == 'dark'
                  ? ColorsManager.white
                  : ColorsManager.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
        filled: true,
        fillColor:
            isDarkMode == 'dark'
                ? ColorsManager.onBackgroundDark
                : ColorsManager.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelLarge,
        labelStyle: Theme.of(context).textTheme.labelLarge,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
          borderSide: BorderSide(
            color:
                isDarkMode == 'dark'
                    ? ColorsManager.darkGreen
                    : ColorsManager.lightGreen,
            width: 4.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
          borderSide: BorderSide(color: ColorsManager.orange, width: 4.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
          borderSide: BorderSide(color: ColorsManager.orange, width: 4.0),
        ),
      ),
      obscureText: isObscure ?? false,
    );
  }
}
