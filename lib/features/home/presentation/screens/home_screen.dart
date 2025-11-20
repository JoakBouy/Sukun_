import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

import 'package:freud_ai/features/home/presentation/widgets/assessment_card.dart';
import 'package:freud_ai/features/home/presentation/widgets/calendar_grid.dart';
import 'package:freud_ai/features/home/presentation/widgets/circular_metric_indicator.dart';
import 'package:freud_ai/features/home/presentation/widgets/feature_card.dart';
import 'package:freud_ai/features/home/presentation/widgets/hero_metric_card.dart';
import 'package:freud_ai/features/home/presentation/widgets/mood_bar_chart.dart';
import 'package:freud_ai/features/home/presentation/widgets/mood_selector_widget.dart';
import 'package:freud_ai/features/home/presentation/widgets/section_header.dart';
import 'package:freud_ai/core/widgets/theme_toggle_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample data - in a real app, this would come from providers/bloc
  double _therapyScore = 0.8;
  int _currentMetricPage = 0;
  final PageController _pageController = PageController();

  // Sample mood data for bar chart (last 12 days)
  final List<double> _moodData = [
    0.1, 0.2, 0.4, 0.35, 0.6, 0.9, 0.75, 0.5, 0.38, 0.1, 0.1, 0.1
  ];

  // Sample calendar data (last 28 days)
  final List<CalendarDayStatus> _journalDays = List.generate(
    28,
    (index) {
      if (index < 5 || (index >= 10 && index < 14) || (index >= 16 && index < 21) || (index >= 25)) {
        return CalendarDayStatus.active;
      } else if (index >= 5 && index < 8) {
        return CalendarDayStatus.partial;
      }
      return CalendarDayStatus.inactive;
    },
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sukun 🌙'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        actions: [
          const ThemeToggleIcon(),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.pushNamed(
                context,
                NavigationManager.notificationsScreen,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
        children: [
          // Combined greeting and mood selector
          const MoodSelectorWidget()
              .animate()
              .fadeIn(duration: AnimationUtils.normal),

          const SizedBox(height: SizesManager.dPadding),

          // Mental Health Assessments Section
          _buildAssessmentsSection(context, colors)
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 300), duration: AnimationUtils.normal)
              .slide(begin: const Offset(0, 0.1)),

          const SizedBox(height: SizesManager.dPadding),

          // Mental Health Metrics Section
          _buildMentalHealthMetricsSection(colors)
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 600), duration: AnimationUtils.normal)
              .slide(begin: const Offset(0, 0.1)),

          const SizedBox(height: SizesManager.dPadding),

          // Essential Quick Actions
          Column(
            children: [
              SectionHeader(
                title: 'Quick Access',
                actionLabel: 'View All',
                onActionTap: () {},
              ).animate()
                  .fadeIn(delay: const Duration(milliseconds: 900), duration: AnimationUtils.normal),

              const SizedBox(height: 16),

              _buildEssentialQuickActions(context, colors)
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 1000), duration: AnimationUtils.normal)
                  .scale(begin: const Offset(0.95, 0.95)),
            ],
          ),

          const SizedBox(height: SizesManager.dPadding),

          // Crisis Support Banner
          _buildCrisisSupportBanner(context, colors)
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 1200), duration: AnimationUtils.normal)
              .slide(begin: const Offset(0, 0.1)),

          const SizedBox(height: SizesManager.dPadding),
        ],
      ),
    );
  }



  /// Assessments section
  Widget _buildAssessmentsSection(BuildContext context, CustomColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        SectionHeader(
          title: 'Mental Health Assessments',
          actionLabel: 'View All',
          onActionTap: () {},
        ),
        AssessmentCard(
          title: 'PHQ-9 Depression Scale',
          subtitle: '9 questions • ~3 min',
          description: 'Evaluate your depression symptoms using the Patient Health Questionnaire.',
          icon: Icons.sentiment_very_dissatisfied,
          accentColor: const Color(0xFF9BB068),
          lastTaken: '2 weeks ago',
          onTap: () {
            Navigator.pushNamed(
              context,
              NavigationManager.assessmentConsentScreen,
              arguments: 'phq9',
            );
          },
        ).animateStaggered(0, baseDelay: const Duration(milliseconds: 400)),
        AssessmentCard(
          title: 'DASS-21 Screening',
          subtitle: '21 questions • ~5 min',
          description: 'Assess depression, anxiety, and stress levels with this comprehensive questionnaire.',
          icon: Icons.trending_up,
          accentColor: const Color(0xFFED7E1C),
          lastTaken: '1 month ago',
          onTap: () {
            Navigator.pushNamed(
              context,
              NavigationManager.assessmentConsentScreen,
              arguments: 'dass21',
            );
          },
        ).animateStaggered(1, baseDelay: const Duration(milliseconds: 400)),
        AssessmentCard(
          title: 'ASQ Suicide Risk',
          subtitle: '4 questions • ~2 min',
          description: 'Quick assessment to evaluate suicide risk using Ask Suicide Screening Questions.',
          icon: Icons.health_and_safety,
          accentColor: Colors.red,
          onTap: () {
            Navigator.pushNamed(
              context,
              NavigationManager.assessmentConsentScreen,
              arguments: 'asq',
            );
          },
        ).animateStaggered(2, baseDelay: const Duration(milliseconds: 400)),
      ],
    );
  }



  /// Mental Health Metrics Section with Hero Cards
  Widget _buildMentalHealthMetricsSection(CustomColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Mental Health Metrics',
          actionLabel: 'View Report',
          onActionTap: () {
            Navigator.pushNamed(
              context,
              NavigationManager.moodTrackingScreen,
            );
          },
        ),
        // Hero metric cards with horizontal scroll
        SizedBox(
          height: 240,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentMetricPage = index);
            },
            children: [
              // First page - Freud Score and Mood
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeroMetricCard(
                    title: 'Freud Score',
                    icon: Icons.psychology,
                    accentColor: const Color(0xFF9BB068),
                    visualization: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularMetricIndicator(
                                progress: _therapyScore,
                                value: '${(_therapyScore * 100).toInt()}',
                                label: 'Healthy',
                                color: const Color(0xFFB4C38C),
                                backgroundColor: const Color(0xFFF2F4EA),
                                size: 120,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationManager.metricDetailScreen,
                        arguments: {
                          'metricType': 'freud_score',
                          'title': 'Freud Score',
                          'accentColor': const Color(0xFF9BB068),
                          'currentValue': '${(_therapyScore * 100).toInt()}',
                          'status': 'Healthy',
                          'message': 'Congratulations! You are mentally healthy.',
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  HeroMetricCard(
                    title: 'Mood',
                    icon: Icons.sentiment_satisfied_alt,
                    accentColor: const Color(0xFFFE804B),
                    visualization: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sad',
                          style: TextStyle(
                            color: Color(0xFFF2F4EA),
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.24,
                          ),
                        ),
                        const SizedBox(height: 6),
                        MoodBarChart(
                          moodValues: _moodData,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationManager.metricDetailScreen,
                        arguments: {
                          'metricType': 'mood',
                          'title': 'Mood',
                          'accentColor': const Color(0xFFFE804B),
                          'currentValue': 'Sad',
                          'status': 'Low',
                          'message': 'Your mood has been low recently. Consider some mindfulness exercises.',
                        },
                      );
                    },
                  ),
                ],
              ),
              // Second page - Health Journal
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeroMetricCard(
                    title: 'Health Journal',
                    icon: Icons.book,
                    accentColor: const Color(0xFFA18EFF),
                    visualization: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '31/365',
                          style: TextStyle(
                            color: Color(0xFFF2F4EA),
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.24,
                          ),
                        ),
                        const SizedBox(height: 6),
                        CalendarGrid(
                          days: _journalDays,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationManager.metricDetailScreen,
                        arguments: {
                          'metricType': 'journal',
                          'title': 'Health Journal',
                          'accentColor': const Color(0xFFA18EFF),
                          'currentValue': '31/365',
                          'status': 'Active',
                          'message': 'Great job! You\'ve been journaling consistently.',
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  // Placeholder for future metric
                  Container(
                    width: 163,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'More metrics\ncoming soon',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Pagination indicators
        _buildPageIndicators(),
      ],
    );
  }

  /// Pagination indicators for hero metrics
  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: ShapeDecoration(
            color: _currentMetricPage == index
                ? const Color(0xFF4B3425)
                : const Color(0xFFE7DDD8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1234),
            ),
          ),
        ),
      ),
    );
  }




  /// Essential Quick Actions - simplified for home screen
  Widget _buildEssentialQuickActions(BuildContext context, CustomColors colors) {
    return Row(
      children: [
        Expanded(
          child: FeatureCard(
            title: 'Voice Journal',
            subtitle: 'Express your thoughts',
            icon: Icons.mic,
            color: colors.primary,
            onTap: () {
              Navigator.pushNamed(
                context,
                NavigationManager.voiceJournalingScreen,
              );
            },
          ).animateCardEntrance(
            delay: const Duration(milliseconds: 1000),
            index: 0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FeatureCard(
            title: 'Habits & Goals',
            subtitle: 'Track your progress',
            icon: Icons.track_changes,
            color: colors.secondary,
            onTap: () {
              Navigator.pushNamed(
                context,
                NavigationManager.habitsScreen,
              );
            },
          ).animateCardEntrance(
            delay: const Duration(milliseconds: 1000),
            index: 1,
          ),
        ),
      ],
    );
  }



  /// Crisis Support Banner
  Widget _buildCrisisSupportBanner(BuildContext context, CustomColors colors) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          NavigationManager.crisisSupportScreen,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.red.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.red.shade200,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emergency,
                color: Colors.white,
                size: 20,
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                duration: const Duration(milliseconds: 1500),
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.1, 1.1),
              ),
            const SizedBox(width: 12),
            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need Immediate Help?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.red.shade900,
                  ),
                ),
                Text(
                  'Crisis support available 24/7',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                NavigationManager.crisisSupportScreen,
              );
            },
            child: const Text(
              'Get Help',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
