import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final String iconPath;
  final bool? isObscure;
  final String? leadingIcon;
  final String isDarkMode;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    required this.iconPath,
    this.isObscure,
    this.leadingIcon,
    required this.isDarkMode,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? showPassword;
  @override
  void initState() {
    super.initState();
    showPassword = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: TextFormField(
        onChanged: (value) => widget.controller.text = value,
        cursorColor: Theme.of(context).extension<CustomColors>()!.green,
        cursorWidth: 3.0,
        cursorHeight: 16.0,
        cursorOpacityAnimates: true,
        style: Theme.of(context).textTheme.labelLarge,
        decoration: InputDecoration(
          suffixIcon:
              widget.leadingIcon != null
                  ? Padding(
                    padding: const EdgeInsets.only(
                      right: SizesManager.hPadding,
                    ),
                    child: IconButton(
                      onPressed:
                          () => setState(() {
                            showPassword = !showPassword!;
                          }),
                      icon: SvgPicture.asset(
                        widget.leadingIcon!,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                          Theme.of(
                            context,
                          ).extension<CustomColors>()!.iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                  : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: SizesManager.hPadding),
            child: SvgPicture.asset(
              widget.iconPath,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.labelLarge,
          labelStyle: Theme.of(context).textTheme.labelLarge,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).extension<CustomColors>()!.greenAccent,
              width: 4.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).extension<CustomColors>()!.orange,
              width: 4.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).extension<CustomColors>()!.orange,
              width: 4.0,
            ),
          ),
        ),
        obscureText: showPassword ?? false,
        validator: widget.validator,
      ),
    );
  }
}
