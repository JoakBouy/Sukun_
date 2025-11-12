import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';

class SessionCard extends StatelessWidget {
  final String therapistName;
  final String date;
  final String time;
  final String type;
  final bool isUpcoming;
  final VoidCallback? onTap;

  const SessionCard({
    super.key,
    required this.therapistName,
    required this.date,
    required this.time,
    required this.type,
    this.isUpcoming = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Card(
      margin: const EdgeInsets.only(bottom: SizesManager.padding),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(SizesManager.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(SizesManager.padding),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      type == StringsManager.virtualSession ? Icons.video_call : Icons.location_on,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: SizesManager.padding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          therapistName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: SizesManager.tinyPadding),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: colors.onPrimaryContainer),
                            const SizedBox(width: 4),
                            Text(
                              date,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(width: SizesManager.padding),
                            Icon(Icons.access_time, size: 16, color: colors.onPrimaryContainer),
                            const SizedBox(width: 4),
                            Text(
                              time,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SizesManager.hPadding,
                      vertical: SizesManager.tinyPadding,
                    ),
                    decoration: BoxDecoration(
                      color: isUpcoming ? colors.greenAccent : colors.greyAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      type,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isUpcoming ? colors.green : colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (isUpcoming) ...[
                const SizedBox(height: SizesManager.padding),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onTap,
                        child: const Text(StringsManager.rescheduleSession),
                      ),
                    ),
                    const SizedBox(width: SizesManager.hPadding),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onTap,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(StringsManager.cancelSession),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

