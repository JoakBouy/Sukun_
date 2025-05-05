import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class CountCard extends StatelessWidget {
  final int count;
  const CountCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SizesManager.hPadding),
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SizesManager.padding,
            vertical: SizesManager.tinyPadding,
          ),
          child: Text(
            '$count of 14',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: SizesManager.font14,
            ),
          ),
        ),
      ),
    );
  }
}
