import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class CountCard extends StatelessWidget {
  final int count;
  const CountCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SizesManager.hPadding),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizesManager.circularBorderRadius,
          ),
        ),
        elevation: 0,
        color: Theme.of(
          context,
        ).extension<CustomColors>()!.lightPrimary.withAlpha(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SizesManager.vPadding - 2,
            vertical: SizesManager.tinyPadding + 2,
          ),
          child: Text(
            '$count of 14',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).extension<CustomColors>()!.lightPrimary,
              fontSize: SizesManager.font14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
