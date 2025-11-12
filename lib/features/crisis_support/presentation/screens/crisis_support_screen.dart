import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/crisis_support/presentation/widgets/crisis_card.dart';

class CrisisSupportScreen extends StatelessWidget {
  const CrisisSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.crisisTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizesManager.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Emergency Banner
            Container(
              padding: const EdgeInsets.all(SizesManager.dPadding),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Column(
                children: [
                  const Icon(Icons.emergency, color: Colors.red, size: 48),
                  const SizedBox(height: SizesManager.padding),
                  Text(
                    StringsManager.youAreNotAlone,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: SizesManager.padding),
                  CustomButton(
                    text: StringsManager.getHelp,
                    onPressed: () {
                      // Call emergency hotline
                    },
                    icon: '',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(height: SizesManager.dPadding),
            Text(
              StringsManager.crisisSubtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: SizesManager.dPadding),
            // Crisis Hotline
            CrisisCard(
              title: StringsManager.crisisHotline,
              subtitle: '988 Suicide & Crisis Lifeline',
              phoneNumber: '988',
              icon: Icons.phone,
              color: Colors.red,
              onTap: () {
                // Call hotline
              },
            ),
            const SizedBox(height: SizesManager.padding),
            // Text Support
            CrisisCard(
              title: StringsManager.textSupport,
              subtitle: 'Text HOME to 741741',
              phoneNumber: '741741',
              icon: Icons.message,
              color: colors.primary,
              onTap: () {
                // Text support
              },
            ),
            const SizedBox(height: SizesManager.padding),
            // Safety Plan
            CrisisCard(
              title: StringsManager.safetyPlan,
              subtitle: 'Create your personal safety plan',
              phoneNumber: '',
              icon: Icons.shield,
              color: colors.violet,
              onTap: () {
                // Navigate to safety plan
              },
            ),
            const SizedBox(height: SizesManager.padding),
            // Resources
            CrisisCard(
              title: StringsManager.resources,
              subtitle: 'Mental health resources and guides',
              phoneNumber: '',
              icon: Icons.book,
              color: colors.secondary,
              onTap: () {
                // Navigate to resources
              },
            ),
            const SizedBox(height: SizesManager.dPadding),
            // Additional Help
            Card(
              child: Padding(
                padding: const EdgeInsets.all(SizesManager.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Additional Resources',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: SizesManager.padding),
                    ListTile(
                      leading: const Icon(Icons.local_hospital),
                      title: const Text('Find a Hospital'),
                      onTap: () {
                        // Find nearby hospitals
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text('Support Groups'),
                      onTap: () {
                        // Find support groups
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Crisis Resources'),
                      onTap: () {
                        // View crisis resources
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

