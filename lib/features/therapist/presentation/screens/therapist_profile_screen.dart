import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:vibration/vibration.dart';

class TherapistProfileScreen extends StatefulWidget {
  final String therapistId;

  const TherapistProfileScreen({
    super.key,
    required this.therapistId,
  });

  @override
  State<TherapistProfileScreen> createState() => _TherapistProfileScreenState();
}

class _TherapistProfileScreenState extends State<TherapistProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Mock therapist data - in real app, this would come from API
  final Map<String, dynamic> _therapistData = {
    'name': 'Dr. Sarah Johnson',
    'title': 'Clinical Psychologist',
    'specialties': ['Anxiety', 'Depression', 'Trauma', 'CBT'],
    'rating': 4.8,
    'reviewCount': 127,
    'experience': '8 years',
    'education': [
      'Ph.D. in Clinical Psychology - Stanford University',
      'M.A. in Counseling Psychology - UCLA',
      'B.A. in Psychology - UC Berkeley',
    ],
    'certifications': [
      'Licensed Clinical Psychologist (CA #12345)',
      'Certified Cognitive Behavioral Therapist',
      'EMDR Certified',
      'Trauma-Focused CBT Certified',
    ],
    'bio': '''Dr. Sarah Johnson is a licensed clinical psychologist with over 8 years of experience helping individuals navigate life's challenges. She specializes in anxiety disorders, depression, and trauma recovery using evidence-based approaches like Cognitive Behavioral Therapy (CBT) and Eye Movement Desensitization and Reprocessing (EMDR).

Her approach combines warmth, empathy, and practical strategies to help clients build resilience and achieve meaningful change. Dr. Johnson believes in creating a safe, non-judgmental space where clients can explore their thoughts and feelings freely.

She has particular expertise in:
• Anxiety and panic disorders
• Depression and mood disorders
• Trauma and PTSD
• Relationship difficulties
• Life transitions and stress management

Dr. Johnson completed her Ph.D. at Stanford University and has published research on the effectiveness of CBT for anxiety disorders. She continues to stay current with the latest research and therapeutic techniques.''',
    'approach': '''Dr. Johnson's therapeutic approach is collaborative and client-centered. She believes that therapy works best when clients are active participants in their healing journey. Her style is warm, empathetic, and direct - she provides honest feedback while maintaining a supportive environment.

She integrates multiple evidence-based modalities:
• Cognitive Behavioral Therapy (CBT)
• Eye Movement Desensitization and Reprocessing (EMDR)
• Mindfulness-based techniques
• Solution-focused therapy

Sessions are structured yet flexible, allowing space for both processing emotions and developing practical coping strategies.''',
    'reviews': [
      {
        'user': 'Anonymous',
        'rating': 5,
        'date': '2024-11-15',
        'comment': 'Dr. Johnson helped me overcome my social anxiety. Her approach was gentle yet effective. I feel like a different person now.',
      },
      {
        'user': 'Anonymous',
        'rating': 5,
        'date': '2024-11-08',
        'comment': 'Very professional and knowledgeable. She really listens and provides practical tools that actually work.',
      },
      {
        'user': 'Anonymous',
        'rating': 4,
        'date': '2024-10-28',
        'comment': 'Great therapist. Helped me work through some deep trauma. Would highly recommend.',
      },
      {
        'user': 'Anonymous',
        'rating': 5,
        'date': '2024-10-20',
        'comment': 'Dr. Johnson is amazing. She made me feel comfortable from the first session and really helped me understand my anxiety patterns.',
      },
    ],
    'availability': [
      {'day': 'Monday', 'times': ['9:00 AM', '2:00 PM', '4:00 PM']},
      {'day': 'Tuesday', 'times': ['10:00 AM', '3:00 PM']},
      {'day': 'Wednesday', 'times': ['9:00 AM', '1:00 PM', '5:00 PM']},
      {'day': 'Thursday', 'times': ['11:00 AM', '4:00 PM']},
      {'day': 'Friday', 'times': ['10:00 AM', '2:00 PM']},
    ],
    'hourlyRate': 150,
    'acceptsInsurance': ['Aetna', 'Blue Cross', 'Cigna', 'UnitedHealthcare'],
    'languages': ['English', 'Spanish'],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with back button and profile image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: colors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.primary,
                      colors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Image
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Name and Title
                    Text(
                      _therapistData['name'],
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _therapistData['title'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // Rating and Experience
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: colors.yellow, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${_therapistData['rating']} (${_therapistData['reviewCount']} reviews)',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.work, color: Colors.white.withOpacity(0.8), size: 20),
                        const SizedBox(width: 4),
                        Text(
                          _therapistData['experience'],
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                color: theme.scaffoldBackgroundColor,
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'Availability'),
                  ],
                  labelColor: colors.primary,
                  unselectedLabelColor: colors.onPrimaryContainer,
                  indicatorColor: colors.primary,
                ),
              ),
            ),
          ),

          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(theme, colors),
                _buildReviewsTab(theme, colors),
                _buildAvailabilityTab(theme, colors),
              ],
            ),
          ),
        ],
      ),

      // Bottom Action Buttons
      bottomNavigationBar: _buildBottomActions(theme, colors),
    );
  }

  Widget _buildAboutTab(ThemeData theme, CustomColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Specialties
          _buildSection(
            title: 'Specialties',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (_therapistData['specialties'] as List<String>).map((specialty) {
                return Chip(
                  label: Text(
                    specialty,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: colors.primaryContainer.withOpacity(0.3),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Bio
          _buildSection(
            title: 'About',
            child: Text(
              _therapistData['bio'],
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: colors.primary,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Approach
          _buildSection(
            title: 'Therapeutic Approach',
            child: Text(
              _therapistData['approach'],
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: colors.primary,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Education
          _buildSection(
            title: 'Education',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (_therapistData['education'] as List<String>).map((education) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.school,
                        size: 20,
                        color: colors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          education,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Certifications
          _buildSection(
            title: 'Certifications & Licenses',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (_therapistData['certifications'] as List<String>).map((cert) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.verified,
                        size: 20,
                        color: colors.green,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          cert,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Languages
          _buildSection(
            title: 'Languages',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (_therapistData['languages'] as List<String>).map((language) {
                return Chip(
                  label: Text(
                    language,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: colors.primaryContainer.withOpacity(0.3),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Insurance
          _buildSection(
            title: 'Accepted Insurance',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (_therapistData['acceptsInsurance'] as List<String>).map((insurance) {
                return Chip(
                  label: Text(
                    insurance,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: colors.primaryContainer.withOpacity(0.3),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildReviewsTab(ThemeData theme, CustomColors colors) {
    final reviews = _therapistData['reviews'] as List<Map<String, dynamic>>;

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: colors.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        color: colors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['user'],
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                          ),
                          Text(
                            review['date'],
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < review['rating'] ? Icons.star : Icons.star_border,
                          size: 16,
                          color: starIndex < review['rating'] ? colors.yellow : colors.grey,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  review['comment'],
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.primary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: index * 100));
      },
    );
  }

  Widget _buildAvailabilityTab(ThemeData theme, CustomColors colors) {
    final availability = _therapistData['availability'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rate Information
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: colors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '\$${_therapistData['hourlyRate']} per session',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Weekly Availability
          Text(
            'Available Times',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 16),

          ...availability.map((day) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day['day'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (day['times'] as List<String>).map((time) {
                        return Chip(
                          label: Text(
                            time,
                            style: TextStyle(
                              color: colors.primary,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: colors.primaryContainer.withOpacity(0.3),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildBottomActions(ThemeData theme, CustomColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: colors.onPrimaryContainer.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                Vibration.vibrate(duration: 50);
                // TODO: Implement messaging
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Messaging feature coming soon!')),
                );
              },
              icon: Icon(Icons.message, color: colors.primary),
              label: const Text('Message'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(color: colors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Vibration.vibrate(duration: 50);
                // TODO: Navigate to booking screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Booking feature coming soon!')),
                );
              },
              icon: Icon(Icons.calendar_today, color: colors.primaryContainer),
              label: const Text('Book Session'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.primaryContainer,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
