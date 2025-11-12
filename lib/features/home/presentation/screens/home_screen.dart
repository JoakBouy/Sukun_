import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/home/presentation/widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sukun 🌙'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizesManager.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SizesManager.hPadding),
            Text(
              'How are you feeling today?',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: SizesManager.dPadding),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: SizesManager.padding,
              mainAxisSpacing: SizesManager.padding,
              childAspectRatio: 1.2,
              children: [
                FeatureCard(
                  title: StringsManager.voiceJournaling,
                  subtitle: 'Express your thoughts',
                  icon: Icons.mic,
                  color: colors.primary,
                  onTap: () {
                    Navigator.pushNamed(context, NavigationManager.voiceJournalingScreen);
                  },
                ),
                FeatureCard(
                  title: StringsManager.findTherapist,
                  subtitle: 'Find professionals',
                  icon: Icons.search,
                  color: colors.secondary,
                  onTap: () {
                    Navigator.pushNamed(context, NavigationManager.findTherapistScreen);
                  },
                ),
                FeatureCard(
                  title: StringsManager.sessions,
                  subtitle: 'Book sessions',
                  icon: Icons.calendar_today,
                  color: colors.violet,
                  onTap: () {
                    Navigator.pushNamed(context, NavigationManager.sessionsScreen);
                  },
                ),
                FeatureCard(
                  title: StringsManager.messaging,
                  subtitle: 'Secure messaging',
                  icon: Icons.message,
                  color: colors.orange,
                  onTap: () {
                    Navigator.pushNamed(context, NavigationManager.messagingScreen);
                  },
                ),
                FeatureCard(
                  title: StringsManager.moodTracking,
                  subtitle: 'Track your mood',
                  icon: Icons.mood,
                  color: colors.yellow,
                  onTap: () {
                    Navigator.pushNamed(context, NavigationManager.moodTrackingScreen);
                  },
                ),
                FeatureCard(
                  title: StringsManager.crisisSupport,
                  subtitle: 'Get help now',
                  icon: Icons.emergency,
                  color: Colors.red,
                  onTap: () {
                    Navigator.pushNamed(context, NavigationManager.crisisSupportScreen);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

