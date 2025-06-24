import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class RadioCard extends StatefulWidget {
  final int value;
  final int groupValue;
  final String title;
  final String icon;
  final void Function(int?) onChanged;

  const RadioCard({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.icon,
    required this.onChanged,
  });

  @override
  State<RadioCard> createState() => _RadioCardState();
}

class _RadioCardState extends State<RadioCard> {
  @override
  Widget build(BuildContext context) {
    final bool selected = widget.groupValue == widget.value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizesManager.tinyPadding),
      child: Card(
        color:
            selected
                ? Theme.of(context).extension<CustomColors>()!.green
                : Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color:
                selected
                    ? Theme.of(context).colorScheme.onPrimaryFixed
                    : Theme.of(context).colorScheme.primaryContainer,
            width: selected ? 4 : 0,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
        ),
        child: RadioListTile<int>(
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
          activeColor: Colors.white,
          controlAffinity: ListTileControlAffinity.trailing,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              SizesManager.circularBorderRadius,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SizesManager.tinyPadding,
              vertical: SizesManager.vPadding,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  colorFilter: ColorFilter.mode(
                    selected
                        ? Theme.of(
                          context,
                        ).extension<CustomColors>()!.activeIconColor
                        : Theme.of(
                          context,
                        ).extension<CustomColors>()!.iconColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: SizesManager.hPadding),
                SizedBox(
                  width:
                      MediaQuery.sizeOf(context).width * 0.5 > 400
                          ? 400
                          : MediaQuery.sizeOf(context).width * 0.5,
                  child: Wrap(
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: SizesManager.smallText2,
                          color:
                              selected
                                  ? Colors.white
                                  : Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
