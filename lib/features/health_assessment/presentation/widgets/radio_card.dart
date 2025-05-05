import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/colors_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class RadioCard extends StatefulWidget {
  final int value;
  final int groupValue;
  final String title;
  final IconData icon;
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

    return Card(
      color:
          selected
              ? ColorsManager.green
              : Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizesManager.circularBorderRadius),
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
              Icon(
                widget.icon,
                color:
                    selected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: SizesManager.hPadding),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: SizesManager.smallText2,
                  color:
                      selected
                          ? Colors.white
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
