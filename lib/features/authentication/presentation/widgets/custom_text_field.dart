import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final String iconPath;
  final bool? isObscure;
  final String? leadingIcon;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    required this.iconPath,
    this.isObscure,
    this.leadingIcon,
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
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      width: 600,
      child: TextFormField(
        onChanged: (value) => widget.controller.text = value,
        cursorColor: theme.extension<CustomColors>()!.green,
        cursorWidth: 3.0,
        cursorHeight: 16.0,
        cursorOpacityAnimates: true,
        style: theme.textTheme.labelLarge,
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
                      icon: SvgPicture(
                        AssetBytesLoader(widget.leadingIcon!),
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                          showPassword!
                              ? theme.extension<CustomColors>()!.iconColor
                              : theme.colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                  : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: SizesManager.hPadding),
            child: SvgPicture(
              AssetBytesLoader(widget.iconPath),
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
          filled: true,
          fillColor: theme.colorScheme.primaryContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hintText,
          hintStyle: theme.textTheme.labelLarge,
          labelStyle: theme.textTheme.labelLarge,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            borderSide: BorderSide(
              color: theme.extension<CustomColors>()!.greenAccent,
              width: 4.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            borderSide: BorderSide(
              color: theme.extension<CustomColors>()!.orange,
              width: 4.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            borderSide: BorderSide(
              color: theme.extension<CustomColors>()!.orange,
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
