import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';

class TherapistCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final String experience;
  final bool availableNow;
  final VoidCallback? onTap;

  const TherapistCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.experience,
    this.availableNow = false,
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
                  // Profile Avatar
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: colors.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: colors.primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: SizesManager.padding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: SizesManager.tinyPadding),
                        Text(
                          specialty,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: SizesManager.tinyPadding),
                        Row(
                          children: [
                            Icon(Icons.star, color: colors.yellow, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '$rating',
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(width: SizesManager.padding),
                            Icon(Icons.work, color: colors.grey, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              experience,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (availableNow)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SizesManager.hPadding,
                        vertical: SizesManager.tinyPadding,
                      ),
                      decoration: BoxDecoration(
                        color: colors.greenAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        StringsManager.availableNow,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: SizesManager.padding),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onTap,
                      child: const Text(StringsManager.viewProfile),
                    ),
                  ),
                  const SizedBox(width: SizesManager.hPadding),
                  Expanded(
                    child: CustomButton(
                      text: StringsManager.bookSession,
                      onPressed: onTap,
                      icon: '',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

