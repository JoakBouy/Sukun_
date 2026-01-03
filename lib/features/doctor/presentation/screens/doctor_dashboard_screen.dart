import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/core/widgets/glass_container.dart';
import 'package:freud_ai/features/home/presentation/widgets/metric_card.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(SizesManager.dPadding),
        children: [
          // Welcome Section
          _buildWelcomeSection(colors),
          
          const SizedBox(height: SizesManager.sectionSpacing),

          // Statistics Cards
          _buildStatisticsSection(colors),

          const SizedBox(height: SizesManager.sectionSpacing),

          // Today's Appointments
          _buildTodaysAppointments(colors),

          const SizedBox(height: SizesManager.sectionSpacing),

          // Quick Actions
          _buildQuickActions(colors),

          const SizedBox(height: SizesManager.sectionSpacing),

          // Recent Activity
          _buildRecentActivity(colors),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(CustomColors colors) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, Dr. Smith',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have 5 appointments today',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.onBackground.withOpacity(0.7),
                ),
          ),
        ],
      ),
    ).animateCardEntrance(index: 0);
  }

  Widget _buildStatisticsSection(CustomColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This Week',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                label: 'Sessions',
                value: '12',
                icon: Icons.event,
                backgroundColor: colors.primaryContainer,
                accentColor: colors.green,
                trend: 'up',
                semanticLabel: 'Sessions this week: 12',
              ).animateCardEntrance(index: 1),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                label: 'New Patients',
                value: '3',
                icon: Icons.person_add,
                backgroundColor: colors.primaryContainer,
                accentColor: colors.orange,
                trend: 'up',
                semanticLabel: 'New patients this week: 3',
              ).animateCardEntrance(index: 2),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                label: 'Avg Rating',
                value: '4.8',
                icon: Icons.star,
                backgroundColor: colors.primaryContainer,
                accentColor: colors.yellow,
                trend: 'stable',
                semanticLabel: 'Average rating: 4.8 stars',
              ).animateCardEntrance(index: 3),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                label: 'Revenue',
                value: '\$2.4K',
                icon: Icons.attach_money,
                backgroundColor: colors.primaryContainer,
                accentColor: colors.violet,
                trend: 'up',
                semanticLabel: 'Revenue this week: \$2,400',
              ).animateCardEntrance(index: 4),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodaysAppointments(CustomColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s Appointments',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(color: colors.green),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(
          3,
          (index) => _buildAppointmentCard(
            colors,
            patientName: ['Sarah Johnson', 'Michael Chen', 'Emma Davis'][index],
            time: ['09:00 AM', '11:00 AM', '02:00 PM'][index],
            type: ['Initial Consultation', 'Follow-up', 'Therapy Session'][index],
            index: index,
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(
    CustomColors colors, {
    required String patientName,
    required String time,
    required String type,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onBackground.withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.green,
                    ),
              ),
              const SizedBox(height: 4),
              Icon(
                Icons.video_call,
                size: 20,
                color: colors.onBackground.withOpacity(0.4),
              ),
            ],
          ),
        ],
      ),
    ).animateCardEntrance(index: index + 5);
  }

  Widget _buildQuickActions(CustomColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                colors,
                icon: Icons.person_add,
                label: 'New Patient',
                color: colors.green,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                colors,
                icon: Icons.calendar_today,
                label: 'Schedule',
                color: colors.orange,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                colors,
                icon: Icons.note_add,
                label: 'Add Note',
                color: colors.violet,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                colors,
                icon: Icons.message,
                label: 'Messages',
                color: colors.yellow,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    ).animateCardEntrance(index: 8);
  }

  Widget _buildActionButton(
    CustomColors colors, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(CustomColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          colors,
          icon: Icons.check_circle,
          title: 'Session completed with Sarah Johnson',
          time: '2 hours ago',
          iconColor: colors.green,
        ),
        _buildActivityItem(
          colors,
          icon: Icons.message,
          title: 'New message from Michael Chen',
          time: '5 hours ago',
          iconColor: colors.orange,
        ),
        _buildActivityItem(
          colors,
          icon: Icons.person_add,
          title: 'New patient request from Emma Davis',
          time: '1 day ago',
          iconColor: colors.violet,
        ),
      ],
    ).animateCardEntrance(index: 9);
  }

  Widget _buildActivityItem(
    CustomColors colors, {
    required IconData icon,
    required String title,
    required String time,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.primary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onBackground.withOpacity(0.5),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
