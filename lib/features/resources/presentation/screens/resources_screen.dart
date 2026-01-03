import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Featured Section
          _buildSectionHeader('Featured', 'View All', colors),
          const SizedBox(height: 12),
          _buildFeaturedCard(
            'Mindfulness in the Digital Age',
            'WELLNESS',
            colors.green,
            colors,
          ),
          const SizedBox(height: 24),

          // Mindful Articles
          _buildSectionHeader('Mindful Articles', 'See All', colors),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildArticleCard(
                  'Meditation for Beginners',
                  'MENTAL HEALTH',
                  '987 LIKES',
                  colors.green,
                  colors,
                ),
                const SizedBox(width: 12),
                _buildArticleCard(
                  'Managing Work Stress',
                  'STRESS',
                  '1.2K LIKES',
                  colors.orange,
                  colors,
                ),
                const SizedBox(width: 12),
                _buildArticleCard(
                  'Sleep & Mental Health',
                  'WELLNESS',
                  '856 LIKES',
                  colors.violet,
                  colors,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Mindful Courses
          _buildSectionHeader('Mindful Courses', null, colors),
          const SizedBox(height: 12),
          _buildCourseCard(
            'Anxiety Management 101',
            '8 Lessons • 45 min',
            0.75,
            colors.green,
            colors,
          ),
          const SizedBox(height: 12),
          _buildCourseCard(
            'Building Resilience',
            '12 Lessons • 1h 20min',
            0.3,
            colors.violet,
            colors,
          ),
          const SizedBox(height: 12),
          _buildCourseCard(
            'Mindful Sleep',
            '6 Lessons • 30 min',
            0.0,
            colors.orange,
            colors,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? action, CustomColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: colors.primary,
            fontFamily: 'urbanist',
          ),
        ),
        if (action != null)
          Text(
            action,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.lightPrimary,
              fontFamily: 'urbanist',
            ),
          ),
      ],
    );
  }

  Widget _buildFeaturedCard(String title, String category, Color categoryColor, CustomColors colors) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [categoryColor.withOpacity(0.3), categoryColor.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: categoryColor.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: categoryColor,
                  fontFamily: 'urbanist',
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: colors.primary,
                    fontFamily: 'urbanist',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '5 min read',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.onBackground.withOpacity(0.6),
                    fontFamily: 'urbanist',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward, color: colors.primary),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildArticleCard(String title, String category, String likes, Color categoryColor, CustomColors colors) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.article, color: categoryColor, size: 24),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: colors.lightPrimary,
                fontFamily: 'urbanist',
                letterSpacing: 1,
              ),
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colors.primary,
              fontFamily: 'urbanist',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.favorite, size: 14, color: colors.orange),
              const SizedBox(width: 4),
              Text(
                likes,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                  fontFamily: 'urbanist',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(String title, String meta, double progress, Color accentColor, CustomColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.play_circle_filled, color: accentColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                    fontFamily: 'urbanist',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meta,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: colors.onBackground.withOpacity(0.6),
                    fontFamily: 'urbanist',
                  ),
                ),
                if (progress > 0) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: colors.background,
                      valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                      minHeight: 6,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colors.grey),
        ],
      ),
    );
  }
}
