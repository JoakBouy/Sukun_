import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/features/doctor/data/models/availability_slot.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String _selectedView = 'Week'; // Week, Day, Month
  DateTime _selectedDate = DateTime.now();

  // Mock appointments
  final List<Map<String, dynamic>> _appointments = [
    {
      'id': '1',
      'patientName': 'Sarah Johnson',
      'time': '09:00 AM',
      'duration': 60,
      'type': 'Initial Consultation',
      'status': 'confirmed',
    },
    {
      'id': '2',
      'patientName': 'Michael Chen',
      'time': '11:00 AM',
      'duration': 45,
      'type': 'Follow-up',
      'status': 'confirmed',
    },
    {
      'id': '3',
      'patientName': 'Emma Davis',
      'time': '02:00 PM',
      'duration': 60,
      'type': 'Therapy Session',
      'status': 'pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Open availability settings
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // View Selector
          Padding(
            padding: const EdgeInsets.all(SizesManager.dPadding),
            child: Row(
              children: [
                _buildViewChip('Day', colors),
                const SizedBox(width: 8),
                _buildViewChip('Week', colors),
                const SizedBox(width: 8),
                _buildViewChip('Month', colors),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.today),
                  onPressed: () {
                    setState(() => _selectedDate = DateTime.now());
                  },
                ),
              ],
            ),
          ),

          // Date Navigation
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SizesManager.dPadding,
              vertical: 12,
            ),
            color: colors.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _selectedDate = _selectedDate.subtract(const Duration(days: 7));
                    });
                  },
                ),
                Text(
                  _formatDateRange(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _selectedDate = _selectedDate.add(const Duration(days: 7));
                    });
                  },
                ),
              ],
            ),
          ),

          // Appointments List
          Expanded(
            child: _appointments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_available,
                          size: 64,
                          color: colors.onBackground.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No appointments scheduled',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colors.onBackground.withOpacity(0.5),
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(SizesManager.dPadding),
                    itemCount: _appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = _appointments[index];
                      return _buildAppointmentCard(appointment, colors, index);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add new appointment
        },
        backgroundColor: colors.green,
        icon: const Icon(Icons.add),
        label: const Text('New Appointment'),
      ),
    );
  }

  Widget _buildViewChip(String label, CustomColors colors) {
    final isSelected = _selectedView == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedView = label);
      },
      selectedColor: colors.green.withOpacity(0.2),
      checkmarkColor: colors.green,
      labelStyle: TextStyle(
        color: isSelected ? colors.green : colors.onBackground,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildAppointmentCard(
    Map<String, dynamic> appointment,
    CustomColors colors,
    int index,
  ) {
    final isConfirmed = appointment['status'] == 'confirmed';
    final statusColor = isConfirmed ? colors.green : colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // View appointment details
          },
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Time Badge
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        appointment['time'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      Text(
                        '${appointment['duration']} min',
                        style: TextStyle(
                          fontSize: 11,
                          color: colors.onBackground.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Appointment Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['patientName'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appointment['type'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onBackground.withOpacity(0.6),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          appointment['status'].toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Button
                IconButton(
                  icon: const Icon(Icons.videocam),
                  color: colors.green,
                  onPressed: () {
                    // Start video call
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ).animateCardEntrance(index: index);
  }

  String _formatDateRange() {
    final start = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    final end = start.add(const Duration(days: 6));
    return '${start.month}/${start.day} - ${end.month}/${end.day}';
  }
}
