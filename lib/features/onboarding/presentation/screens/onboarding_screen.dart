import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:freud_ai/core/widgets/lively_button.dart';
import 'package:freud_ai/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:freud_ai/features/onboarding/data/models/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageModel> _pages = const [
    OnboardingPageModel(
      title: 'Welcome to Sukun 🌙',
      description: 'Your personal mental wellness companion',
      icon: Icons.favorite,
      accentColor: Color(0xFF9BB168),
    ),
    OnboardingPageModel(
      title: 'Track Your Journey',
      description: 'Monitor your mood, journal your thoughts, and see your progress',
      icon: Icons.trending_up,
      accentColor: Color(0xFFED7E1C),
      features: [
        '📝 Daily journaling',
        '📊 Mood tracking',
        '💡 Personalized insights',
      ],
    ),
    OnboardingPageModel(
      title: 'Guided Exercises',
      description: 'Practice mindfulness with breathing exercises and meditation',
      icon: Icons.self_improvement,
      accentColor: Color(0xFFA694F5),
      features: [
        '🧘 Breathing exercises',
        '🎵 Guided meditation',
        '😌 Relaxation techniques',
      ],
    ),
    OnboardingPageModel(
      title: 'Connect with Professionals',
      description: 'Book sessions with licensed therapists when you need support',
      icon: Icons.people,
      accentColor: Color(0xFFFFBD1A),
      features: [
        '👨‍⚕️ Licensed therapists',
        '📅 Easy scheduling',
        '💬 Secure messaging',
      ],
    ),
    OnboardingPageModel(
      title: 'Your Privacy Matters',
      description: 'Your data is encrypted and stored securely. We never share your information.',
      icon: Icons.lock,
      accentColor: Color(0xFF736B66),
    ),
    OnboardingPageModel(
      title: 'Begin Your Journey',
      description: 'Take the first step towards better mental health',
      icon: Icons.rocket_launch,
      accentColor: Color(0xFF9BB168),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(NavigationManager.mainNavigation);
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final primaryGradient = LinearGradient(
      colors: [colors.green, colors.lightPrimary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.background,
              colors.primaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _skipOnboarding,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: colors.onBackground.withOpacity(0.6),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index], colors);
                  },
                ),
              ),

              // Page indicator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: OnboardingPageIndicator(
                  currentPage: _currentPage,
                  totalPages: _pages.length,
                ),
              ),

              // Next/Get Started button
              Padding(
                padding: const EdgeInsets.all(24),
                child: LivelyButton(
                  onPressed: _nextPage,
                  gradient: primaryGradient,
                  width: double.infinity,
                  height: 56,
                  enablePulse: _currentPage == _pages.length - 1,
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPageModel page, CustomColors colors) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: page.accentColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 64,
              color: page.accentColor,
            ),
          )
              .animate()
              .scale(
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),

          const SizedBox(height: 48),

          // Title
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 400),
              )
              .slideY(
                begin: 0.3,
                end: 0,
                curve: Curves.easeOut,
              ),

          const SizedBox(height: 16),

          // Description
          Text(
            page.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.onBackground.withOpacity(0.7),
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 400),
              )
              .slideY(
                begin: 0.3,
                end: 0,
                curve: Curves.easeOut,
              ),

          // Features (if any)
          if (page.features != null) ...[
            const SizedBox(height: 32),
            ...page.features!.asMap().entries.map((entry) {
              final index = entry.key;
              final feature = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: page.accentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        feature,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: colors.onBackground,
                            ),
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 600 + (index * 100)),
                    duration: const Duration(milliseconds: 400),
                  )
                  .slideX(
                    begin: -0.2,
                    end: 0,
                    curve: Curves.easeOut,
                  );
            }),
          ],
        ],
      ),
    );
  }
}
