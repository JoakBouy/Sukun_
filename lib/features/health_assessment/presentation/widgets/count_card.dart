import 'package:flutter/material.dart';

class CountCard extends StatelessWidget {
  final int count;
  const CountCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
          child: Text(
            '$count of 14',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
