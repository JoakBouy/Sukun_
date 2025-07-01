import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class CustomLargeTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  const CustomLargeTextField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
  });

  @override
  State<CustomLargeTextField> createState() => _CustomLargeTextFieldState();
}

class _CustomLargeTextFieldState extends State<CustomLargeTextField> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizesManager.circularBorderRadius),
        color: theme.colorScheme.secondary,
        border: Border.all(
          color: theme.extension<CustomColors>()!.greenAccent,
          width: 4,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(
          minLines: 5,
          maxLines: 5,
          onChanged: (value) => widget.controller.text = value,
          cursorColor: theme.extension<CustomColors>()!.green,
          cursorWidth: 3.0,
          cursorHeight: 16.0,
          cursorOpacityAnimates: true,
          style: theme.textTheme.labelLarge,
          decoration: InputDecoration(
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
          ),
        ),
      ),
    );
  }
}
