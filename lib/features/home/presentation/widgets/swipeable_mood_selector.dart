import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class SwipeableMoodSelector extends StatefulWidget {
  const SwipeableMoodSelector({super.key});

  @override
  State<SwipeableMoodSelector> createState() => _SwipeableMoodSelectorState();
}

class _SwipeableMoodSelectorState extends State<SwipeableMoodSelector> {
  late PageController _pageController;
  int _currentPage = 0; // Start with first mood

  final List<MoodPageData> _moodPages = [
    MoodPageData(
      emoji: '🤩',
      label: 'I\'m Feeling Overjoyed',
      backgroundColor: const Color(0xFF9BB068),
      circleColor: const Color(0xFFCFD8B5),
      activeDotIndex: 0,
    ),
    MoodPageData(
      emoji: '😊',
      label: 'I\'m Feeling Happy',
      backgroundColor: const Color(0xFFFFCE5B),
      circleColor: const Color(0xFFFFEAC1),
      activeDotIndex: 1,
    ),
    MoodPageData(
      emoji: '😐',
      label: 'I\'m Feeling Neutral',
      backgroundColor: const Color(0xFF926247),
      circleColor: const Color(0xFFBDA193),
      activeDotIndex: 2,
    ),
    MoodPageData(
      emoji: '😢',
      label: 'I\'m Feeling Sad',
      backgroundColor: const Color(0xFFFE804B),
      circleColor: const Color(0xFFFEAE8F),
      activeDotIndex: 3,
    ),
    MoodPageData(
      emoji: '😔',
      label: 'I\'m Feeling Depressed',
      backgroundColor: const Color(0xFFA18EFF),
      circleColor: const Color(0xFFCAC1FF),
      activeDotIndex: 4,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onDotTapped(int dotIndex) {
    _pageController.animateToPage(
      dotIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _setMood() {
    // In a real app, this would save to database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mood set to ${_moodPages[_currentPage].label}'),
        duration: const Duration(seconds: 2),
      ),
    );
    // Navigate back to home screen
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentMood = _moodPages[_currentPage];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: currentMood.backgroundColor,
        ),
        child: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _moodPages.length,
            itemBuilder: (context, index) {
              final mood = _moodPages[index];
              return _buildMoodPage(mood, index == _currentPage);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMoodPage(MoodPageData mood, bool isCurrentPage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Central mood circle with dots
        SizedBox(
          width: 343,
          height: 256,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Central circle
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 160,
                height: 160,
                decoration: ShapeDecoration(
                  color: mood.circleColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8226.67),
                  ),
                  shadows: mood.backgroundColor == const Color(0xFFFFCE5B) ? [
                    const BoxShadow(
                      color: Color(0x19FFBD1A),
                      blurRadius: 0,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    ),
                    const BoxShadow(
                      color: Color(0x19FFBD1A),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                    const BoxShadow(
                      color: Color(0x16FFBD1A),
                      blurRadius: 18,
                      offset: Offset(0, 18),
                      spreadRadius: 0,
                    ),
                    const BoxShadow(
                      color: Color(0x0CFFBD1A),
                      blurRadius: 24,
                      offset: Offset(0, 40),
                      spreadRadius: 0,
                    ),
                    const BoxShadow(
                      color: Color(0x02FFBD1A),
                      blurRadius: 28,
                      offset: Offset(0, 70),
                      spreadRadius: 0,
                    ),
                    const BoxShadow(
                      color: Color(0x00FFBD1A),
                      blurRadius: 31,
                      offset: Offset(0, 110),
                      spreadRadius: 0,
                    ),
                  ] : null,
                ),
                child: Center(
                  child: Text(
                    mood.emoji,
                    style: const TextStyle(fontSize: 60),
                  ).animate(target: isCurrentPage ? 1 : 0).scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    duration: 300.ms,
                    curve: Curves.elasticOut,
                  ),
                ),
              ).animate(target: isCurrentPage ? 1 : 0).scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.0, 1.0),
                duration: 300.ms,
                curve: Curves.elasticOut,
              ),

                // Mood dots arranged in a circle
                ...List.generate(5, (index) {
                  // Calculate position in circle - adjusted for better positioning
                  final angle = (index * 72.0 - 90.0) * math.pi / 180.0; // Start from top
                  final radius = 110.0; // Slightly smaller radius to fit better
                  final centerX = 171.5; // Center of the container (343/2)
                  final centerY = 128.0; // Center of the container (256/2)

                  final x = centerX + radius * math.cos(angle) - 18; // 18 is half of dot size
                  final y = centerY + radius * math.sin(angle) - 18; // 18 is half of dot size

                  final isActive = index == mood.activeDotIndex;

                  return Positioned(
                    left: x.clamp(0, 343 - 36), // Ensure dots stay within bounds
                    top: y.clamp(0, 256 - 36),  // Ensure dots stay within bounds
                    child: GestureDetector(
                      onTap: () => _onDotTapped(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 36,
                        height: 36,
                        decoration: ShapeDecoration(
                          color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 3,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: isActive ? mood.backgroundColor : Colors.white.withOpacity(0.6),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          shadows: isActive ? [
                            BoxShadow(
                              color: mood.backgroundColor.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ] : null,
                        ),
                        child: Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: ShapeDecoration(
                              color: isActive ? mood.backgroundColor : Colors.white.withOpacity(0.8),
                              shape: const OvalBorder(),
                            ),
                          ),
                        ),
                      ).animate(target: isCurrentPage ? 1 : 0).scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.0, 1.0),
                        duration: 300.ms,
                        delay: Duration(milliseconds: index * 50),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Mood label
        Text(
          mood.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: mood.backgroundColor == const Color(0xFFFFCE5B) ? const Color(0xFF4B3425) : Colors.white,
            fontSize: 24,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.24,
          ),
        ).animate(target: isCurrentPage ? 1 : 0).fadeIn(duration: 300.ms, delay: 200.ms),

        const SizedBox(height: 48),

        // Set Mood button
        GestureDetector(
          onTap: _setMood,
          child: Container(
            width: 343,
            height: 56,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Center(
              child: Text(
                'Set Mood',
                style: const TextStyle(
                  color: Color(0xFF4B3425),
                  fontSize: 18,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.18,
                ),
              ),
            ),
          ),
        ).animate(target: isCurrentPage ? 1 : 0).fadeIn(duration: 300.ms, delay: 300.ms),
      ],
    );
  }
}

class MoodPageData {
  final String emoji;
  final String label;
  final Color backgroundColor;
  final Color circleColor;
  final int activeDotIndex;

  const MoodPageData({
    required this.emoji,
    required this.label,
    required this.backgroundColor,
    required this.circleColor,
    required this.activeDotIndex,
  });
}
