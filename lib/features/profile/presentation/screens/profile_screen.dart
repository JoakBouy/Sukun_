import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:freud_ai/features/profile/presentation/widgets/habit_tracker_card.dart';
import 'package:freud_ai/features/profile/presentation/widgets/resource_card.dart';
import 'package:freud_ai/core/widgets/ref/ref_button.dart';
import 'package:freud_ai/core/widgets/accessible_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _navigateToSettings(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // User Profile Header
          _buildProfileHeader(),
          const SizedBox(height: 32),

          // Mental Health Goals & Habits
          Text(
            'Your Journey',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ),
          const SizedBox(height: 16),

          // Habit Trackers
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, NavigationManager.habitsScreen),
            child: HabitTrackerCard(
              title: 'Daily Journaling',
              subtitle: '34/365 days completed',
              progress: 0.094, // 34/365
              color: const Color(0xFF9BB068),
              streak: 7,
              icon: Icons.book,
            ),
          ),
          const SizedBox(height: 12),

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, NavigationManager.habitsScreen),
            child: HabitTrackerCard(
              title: 'Weekly Exercises',
              subtitle: '3/4 sessions this week',
              progress: 0.75,
              color: const Color(0xFFA18EFF),
              streak: 3,
              icon: Icons.fitness_center,
            ),
          ),
          const SizedBox(height: 12),

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, NavigationManager.habitsScreen),
            child: HabitTrackerCard(
              title: 'Mood Tracking',
              subtitle: '12/31 days this month',
              progress: 0.387,
              color: const Color(0xFFFFCE5B),
              streak: 12,
              icon: Icons.sentiment_satisfied,
            ),
          ),
          const SizedBox(height: 32),

          // Resources Section
          Text(
            'Resources & Support',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ),
          const SizedBox(height: 16),

          ResourceCard(
            title: 'Mental Health Articles',
            description: 'Evidence-based articles on mental wellness',
            icon: Icons.article,
            color: const Color(0xFF9BB068),
            onTap: () => _navigateToArticles(context),
          ),
          const SizedBox(height: 12),

          ResourceCard(
            title: 'Crisis Support',
            description: '24/7 emergency mental health support',
            icon: Icons.emergency,
            color: Colors.red,
            onTap: () => _navigateToCrisisSupport(context),
          ),
          const SizedBox(height: 12),

          ResourceCard(
            title: 'Community Forum',
            description: 'Connect with others on similar journeys',
            icon: Icons.people,
            color: const Color(0xFFA18EFF),
            onTap: () => _navigateToCommunity(context),
          ),
          const SizedBox(height: 12),

          ResourceCard(
            title: 'Therapy Directory',
            description: 'Find licensed therapists in your area',
            icon: Icons.search,
            color: const Color(0xFFBDA193),
            onTap: () => _navigateToTherapists(context),
          ),
          const SizedBox(height: 32),

          // TEMPORARY: Doctor Portal Test Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Column(
              children: [
                const Text(
                  '🧪 TESTING MODE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    NavigationManager.doctorNavigationScreen,
                  ),
                  icon: const Icon(Icons.medical_services),
                  label: const Text('View Doctor Dashboard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    NavigationManager.adminNavigationScreen,
                  ),
                  icon: const Icon(Icons.admin_panel_settings),
                  label: const Text('View Admin Portal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Account & Settings
          Text(
            'Account & Settings',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ),
          const SizedBox(height: 16),

          ProfileMenuItem(
            title: 'Personal Information',
            subtitle: 'Update your profile details',
            icon: Icons.person,
            onTap: () => _navigateToPersonalInfo(context),
          ),

          ProfileMenuItem(
            title: 'Privacy & Security',
            subtitle: 'Manage your data and privacy settings',
            icon: Icons.security,
            onTap: () => _navigateToPrivacy(context),
          ),

          ProfileMenuItem(
            title: 'Notifications',
            subtitle: 'Customize your notification preferences',
            icon: Icons.notifications,
            onTap: () => _navigateToNotifications(context),
          ),

          ProfileMenuItem(
            title: 'Help & Support',
            subtitle: 'Get help and contact support',
            icon: Icons.help,
            onTap: () => _navigateToHelp(context),
          ),

          ProfileMenuItem(
            title: 'About Sukun',
            subtitle: 'App version and information',
            icon: Icons.info,
            onTap: () => _navigateToAbout(context),
          ),

          const SizedBox(height: 32),

          // FAQ Section
          Text(
            'Frequently Asked Questions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B3425),
            ),
          ),
          const SizedBox(height: 16),
          _buildFaqItem(
            context,
            'How do I book a session?',
            'You can book a session by navigating to the Booking tab and selecting an available slot.',
          ),
          _buildFaqItem(
            context,
            'Is my data private?',
            'Yes, your data is encrypted and stored securely. We prioritize your privacy.',
          ),
          _buildFaqItem(
            context,
            'Can I cancel a booking?',
            'Yes, you can cancel a booking up to 24 hours in advance from the Booking tab.',
          ),

          const SizedBox(height: 32),

          // Contact Support
          RefButton(
            label: 'Contact Support',
            onPressed: () => _navigateToHelp(context),
            type: ButtonType.primary,
            icon: Icons.headset_mic,
          ),

          const SizedBox(height: 32),

          // Sign Out Button
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: TextButton(
              onPressed: () => _showSignOutDialog(context),
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF9BB068).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF9BB068).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF9BB068),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'S',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buoy Gai',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4B3425),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Member since November 2025',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF7A6F5C),
                  ),
                ),
                const SizedBox(height: 8),

                // Quick Stats
                Row(
                  children: [
                    _buildStat('34', 'Journals'),
                    const SizedBox(width: 24),
                    _buildStat('12', 'Assessments'),
                    const SizedBox(width: 24),
                    _buildStat('7', 'Day Streak'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4B3425),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF7A6F5C),
          ),
        ),
      ],
    );
  }

  void _navigateToSettings(BuildContext context) {
    // TODO: Navigate to settings screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings coming soon!')),
    );
  }

  void _navigateToArticles(BuildContext context) {
    // TODO: Navigate to articles screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Articles coming soon!')),
    );
  }

  void _navigateToCrisisSupport(BuildContext context) {
    // TODO: Navigate to crisis support
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Crisis support coming soon!')),
    );
  }

  void _navigateToCommunity(BuildContext context) {
    // TODO: Navigate to community forum
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Community coming soon!')),
    );
  }

  void _navigateToTherapists(BuildContext context) {
    // TODO: Navigate to therapist directory
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Therapists coming soon!')),
    );
  }

  void _navigateToPersonalInfo(BuildContext context) {
    // TODO: Navigate to personal info screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Personal info coming soon!')),
    );
  }

  void _navigateToPrivacy(BuildContext context) {
    // TODO: Navigate to privacy settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Privacy settings coming soon!')),
    );
  }

  void _navigateToNotifications(BuildContext context) {
    // TODO: Navigate to notification settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification settings coming soon!')),
    );
  }

  void _navigateToHelp(BuildContext context) {
    // TODO: Navigate to help & support
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help & support coming soon!')),
    );
  }

  void _navigateToAbout(BuildContext context) {
    // TODO: Navigate to about screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('About Sukun coming soon!')),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement sign out logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out successfully')),
              );
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF4B3425),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                color: const Color(0xFF4B3425).withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
