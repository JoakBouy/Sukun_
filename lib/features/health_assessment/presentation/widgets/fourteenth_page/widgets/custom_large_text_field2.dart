import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class CustomLargeTextField2 extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  const CustomLargeTextField2({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
  });

  @override
  State<CustomLargeTextField2> createState() => _CustomLargeTextField2State();
}

class _CustomLargeTextField2State extends State<CustomLargeTextField2> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle textTheme = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.primary.withAlpha(200),
    );
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
            color: theme.colorScheme.primary,
            border: Border.all(
              color: theme.colorScheme.primary.withAlpha(80),
              width: 4,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextFormField(
              minLines: 5,
              maxLines: 5,
              onChanged:
                  (value) => setState(() {
                    widget.controller.text = value;
                  }),
              cursorColor: theme.extension<CustomColors>()!.lightPrimary,
              cursorWidth: 4.0,
              cursorHeight: 32.0,
              cursorOpacityAnimates: true,
              style: textTheme.copyWith(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colorScheme.primaryContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    SizesManager.circularBorderRadius,
                  ),
                  borderSide: BorderSide.none,
                ),
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.hintText,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary.withAlpha(200),
                    ),
                  ),
                ),
                labelStyle: textTheme,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture(
                AssetBytesLoader(theme.extension<CustomAssets>()!.icon14_1),
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimaryContainer.withAlpha(100),
                  BlendMode.srcIn,
                ),
              ),
              Text(
                widget.controller.text.isEmpty
                    ? '75/250'
                    : "${widget.controller.text.length.toString()} / 250",
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onPrimaryContainer.withAlpha(100),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
