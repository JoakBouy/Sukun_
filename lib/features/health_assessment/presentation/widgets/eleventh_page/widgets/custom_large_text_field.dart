import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eleventh_page/widgets/auto_sized_text_field.dart';

class CustomLargeTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<String> healthSymptoms;
  const CustomLargeTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.healthSymptoms,
  });

  @override
  State<CustomLargeTextField> createState() => _CustomLargeTextFieldState();
}

class _CustomLargeTextFieldState extends State<CustomLargeTextField> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(SizesManager.circularBorderRadius),
      onTap: () => widget.focusNode.requestFocus(),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                SizesManager.circularBorderRadius,
              ),
              color: theme.colorScheme.secondary,
              border: Border.all(
                color: theme.extension<CustomColors>()!.greenAccent,
                width: 4,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizesManager.circularBorderRadius,
                  ),
                  color: theme.colorScheme.primaryContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ...List.generate(
                        widget.healthSymptoms.length,
                        (index) => Card(
                          color: theme.colorScheme.secondary.withAlpha(80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SizesManager.cardCircularBorderRadius,
                            ),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 8.0,
                            ),
                            child: Text(
                              widget.healthSymptoms[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AutoSizedTextField(
                        controller: widget.controller,
                        focusNode: widget.focusNode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  theme.extension<CustomAssets>()!.icon14_1,
                  width: 24,
                  height: 24,
                ),
                Text(
                  "${widget.healthSymptoms.length} / 10",
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
