import 'package:flutter/material.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/data/models/sleep_time_item.dart';

class SleepTimeChild extends StatelessWidget {
  const SleepTimeChild({
    super.key,
    required this.item,
    required this.isSelected,
  });
  final SleepTimeItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = theme.colorScheme.onSurface.withAlpha(
      isSelected ? 255 : 60,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          item.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 16,
            color: color,
          ),
        ),
        Row(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.watch_later,
              color: Colors.grey.withAlpha(isSelected ? 255 : 60),
              size: 16,
            ),
            Text(
              item.subtitle,
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 10,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
