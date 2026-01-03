import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/core/widgets/theme_toggle_icon.dart';
import 'package:freud_ai/core/widgets/ref/ref_button.dart';
import 'package:freud_ai/core/widgets/accessible_button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;
  String? _selectedTherapist;

  // Sample therapists data
  final List<Map<String, dynamic>> _therapists = [
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Anxiety & Depression',
      'rating': 4.9,
      'sessions': 1250,
      'image': '👩‍⚕️',
      'color': Color(0xFF9BB068),
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Trauma & PTSD',
      'rating': 4.8,
      'sessions': 980,
      'image': '👨‍⚕️',
      'color': Color(0xFFA18EFF),
    },
    {
      'name': 'Dr. Emily Rodriguez',
      'specialty': 'Relationship Therapy',
      'rating': 4.9,
      'sessions': 1100,
      'image': '👩‍⚕️',
      'color': Color(0xFFFE804B),
    },
  ];

  // Sample time slots
  final List<String> _timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  // Sample upcoming sessions
  final List<Map<String, dynamic>> _upcomingSessions = [
    {
      'therapist': 'Dr. Sarah Johnson',
      'date': 'Today, 3:00 PM',
      'type': 'Video Call',
      'status': 'confirmed',
      'color': Color(0xFF9BB068),
    },
    {
      'therapist': 'Dr. Michael Chen',
      'date': 'Tomorrow, 10:00 AM',
      'type': 'Messaging',
      'status': 'confirmed',
      'color': Color(0xFFA18EFF),
    },
  ];

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
      appBar: AppBar(
        title: const Text('Book Session'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          ThemeToggleIcon(),
          SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: colors.primary,
          unselectedLabelColor: colors.onBackground.withOpacity(0.6),
          indicatorColor: colors.primary,
          tabs: const [
            Tab(text: 'Book New'),
            Tab(text: 'Upcoming'),
            Tab(text: 'Sessions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookNewTab(theme, colors),
          _buildUpcomingTab(theme, colors),
          _buildSessionsTab(theme, colors),
        ],
      ),
    );
  }

  Widget _buildBookNewTab(ThemeData theme, CustomColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SizesManager.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Indicator
          _buildProgressIndicator(theme, colors),
          const SizedBox(height: 24),

          // Select Therapist Section
          _buildSectionHeader('Select Therapist', theme),
          const SizedBox(height: 16),
          _buildTherapistList(theme, colors),

          const SizedBox(height: SizesManager.dPadding),

          // Calendar Section
          _buildSectionHeader('Select Date', theme),
          const SizedBox(height: 16),
          _buildCalendar(theme, colors),

          const SizedBox(height: SizesManager.dPadding),

          // Time Slots Section
          _buildSectionHeader('Select Time', theme),
          const SizedBox(height: 16),
          _buildTimeSlots(theme, colors),

          const SizedBox(height: SizesManager.dPadding),

          // Book Button
          _buildBookButton(theme, colors),
        ],
      ),
    );
  }


  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildTherapistList(ThemeData theme, CustomColors colors) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _therapists.length,
        itemBuilder: (context, index) {
          final therapist = _therapists[index];
          final isSelected = _selectedTherapist == therapist['name'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTherapist = therapist['name'] as String;
              });
            },
            child: AnimatedContainer(
              duration: AnimationUtils.fast,
              width: 150,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? (therapist['color'] as Color).withOpacity(0.1)
                    : theme.cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? (therapist['color'] as Color)
                      : colors.grey.withOpacity(0.2),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (therapist['color'] as Color).withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        therapist['image'] as String,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const Spacer(),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: therapist['color'] as Color,
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    therapist['name'] as String,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    therapist['specialty'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onBackground.withOpacity(0.6),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${therapist['rating']}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${therapist['sessions']}+',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onBackground.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animateCardEntrance(index: index);
        },
      ),
    );
  }

  Widget _buildCalendar(ThemeData theme, CustomColors colors) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final startingWeekday = firstDayOfMonth.weekday % 7;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          // Month/Year header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {},
              ),
              Text(
                '${_getMonthName(now.month)} ${now.year}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map((day) => SizedBox(
                      width: 40,
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onBackground.withOpacity(0.6),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final dayNumber = index - startingWeekday + 1;
              final isValidDay = dayNumber > 0 && dayNumber <= daysInMonth;
              final isToday = isValidDay && dayNumber == now.day;
              final date = isValidDay ? DateTime(now.year, now.month, dayNumber) : null;
              final isSelected = date != null &&
                  date.year == _selectedDate.year &&
                  date.month == _selectedDate.month &&
                  date.day == _selectedDate.day;

              if (!isValidDay) {
                return const SizedBox();
              }

              return GestureDetector(
                onTap: () {
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: AnimationUtils.fast,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primary
                        : isToday
                            ? colors.primary.withOpacity(0.1)
                            : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isToday && !isSelected
                        ? Border.all(color: colors.primary, width: 1)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      '$dayNumber',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? Colors.white
                            : isToday
                                ? colors.primary
                                : colors.onBackground,
                        fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: const Duration(milliseconds: 100));
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Widget _buildTimeSlots(ThemeData theme, CustomColors colors) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _timeSlots.map((time) {
        final isSelected = _selectedTimeSlot == time;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTimeSlot = time;
            });
          },
          child: AnimatedContainer(
            duration: AnimationUtils.fast,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? colors.primary : theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? colors.primary : colors.grey.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              time,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : colors.onBackground,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBookButton(ThemeData theme, CustomColors colors) {
    final canBook = _selectedTherapist != null && _selectedTimeSlot != null;

    return RefButton(
      label: 'Book Session',
      onPressed: canBook
          ? () {
              _showBookingConfirmation(context, theme, colors);
            }
          : () {}, // Disabled state handled by RefButton if we add support, or just no-op
      type: ButtonType.primary,
      // Note: RefButton doesn't explicitly support disabled state in the same way, 
      // but we can handle it or just let it be clickable but do nothing if not valid?
      // Better to use the isLoading or add disabled support to RefButton.
      // For now, I'll just use it as is, maybe add a check in onPressed.
    );
  }

  Widget _buildProgressIndicator(ThemeData theme, CustomColors colors) {
    int currentStep = 0;
    if (_selectedTherapist != null) currentStep = 1;
    if (_selectedDate != null) currentStep = 2; // Date is always selected by default
    if (_selectedTimeSlot != null) currentStep = 3;

    return Row(
      children: [
        _buildStep(theme, colors, 1, 'Therapist', currentStep >= 1),
        _buildStepDivider(colors, currentStep >= 2),
        _buildStep(theme, colors, 2, 'Date', currentStep >= 2),
        _buildStepDivider(colors, currentStep >= 3),
        _buildStep(theme, colors, 3, 'Time', currentStep >= 3),
      ],
    );
  }

  Widget _buildStep(ThemeData theme, CustomColors colors, int step, String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? colors.primary : theme.cardColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? colors.primary : colors.grey.withOpacity(0.3),
              ),
            ),
            child: Center(
              child: isActive
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(
                      '$step',
                      style: TextStyle(
                        color: colors.onBackground.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isActive ? colors.primary : colors.onBackground.withOpacity(0.6),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDivider(CustomColors colors, bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? colors.primary : colors.grey.withOpacity(0.2),
    );
  }

  void _showBookingConfirmation(BuildContext context, ThemeData theme, CustomColors colors) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Therapist: $_selectedTherapist'),
            const SizedBox(height: 8),
            Text('Date: ${_selectedDate.toString().split(' ')[0]}'),
            const SizedBox(height: 8),
            Text('Time: $_selectedTimeSlot'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Session booked successfully!'),
                  backgroundColor: colors.primary,
                ),
              );
              setState(() {
                _tabController.animateTo(1); // Switch to Upcoming tab
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }



  Widget _buildUpcomingTab(ThemeData theme, CustomColors colors) {
    return ListView(
      padding: const EdgeInsets.all(SizesManager.padding),
      children: [
        Text(
          'Upcoming Sessions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(),
        const SizedBox(height: 16),
        ..._upcomingSessions.asMap().entries.map((entry) {
          final index = entry.key;
          final session = entry.value;
          return _buildSessionCard(
            theme,
            colors,
            session,
            isUpcoming: true,
          ).animateCardEntrance(index: index);
        }),
      ],
    );
  }

  Widget _buildSessionsTab(ThemeData theme, CustomColors colors) {
    return ListView(
      padding: const EdgeInsets.all(SizesManager.padding),
      children: [
        Text(
          'Past Sessions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(),
        const SizedBox(height: 16),
        _buildSessionCard(
          theme,
          colors,
          {
            'therapist': 'Dr. Sarah Johnson',
            'date': 'Dec 10, 2:00 PM',
            'type': 'Video Call',
            'status': 'completed',
            'color': const Color(0xFF9BB068),
          },
          isUpcoming: false,
        ),
        const SizedBox(height: 12),
        _buildSessionCard(
          theme,
          colors,
          {
            'therapist': 'Dr. Michael Chen',
            'date': 'Dec 8, 11:00 AM',
            'type': 'Messaging',
            'status': 'completed',
            'color': const Color(0xFFA18EFF),
          },
          isUpcoming: false,
        ),
      ],
    );
  }

  Widget _buildSessionCard(
    ThemeData theme,
    CustomColors colors,
    Map<String, dynamic> session, {
    required bool isUpcoming,
  }) {
    final sessionColor = session['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: sessionColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: sessionColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: sessionColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  session['type'] == 'Video Call' ? Icons.videocam : Icons.message,
                  color: sessionColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session['therapist'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: colors.onBackground.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          session['date'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onBackground.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: sessionColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  session['type'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: sessionColor,
                  ),
                ),
              ),
            ],
          ),
          if (isUpcoming) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (session['type'] == 'Video Call') {
                        _startVideoCall(context, session);
                      } else {
                        _openMessaging(context, session);
                      }
                    },
                    icon: Icon(
                      session['type'] == 'Video Call' ? Icons.videocam : Icons.message,
                      size: 18,
                    ),
                    label: Text(
                      session['type'] == 'Video Call' ? 'Join Call' : 'Open Chat',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: sessionColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    _showCancelDialog(context, theme, colors);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _startVideoCall(BuildContext context, Map<String, dynamic> session) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.videocam,
                size: 64,
                color: Color(0xFF9BB068),
              ),
              const SizedBox(height: 16),
              Text(
                'Video Call',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Starting video call with ${session['therapist']}...',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic_off),
                    iconSize: 32,
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.videocam_off),
                    iconSize: 32,
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.call_end),
                    iconSize: 32,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openMessaging(BuildContext context, Map<String, dynamic> session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _MessagingScreen(
          therapistName: session['therapist'] as String,
          therapistColor: session['color'] as Color,
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, ThemeData theme, CustomColors colors) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Cancel Session'),
        content: const Text('Are you sure you want to cancel this session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Session cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}


// Messaging Screen
class _MessagingScreen extends StatefulWidget {
  final String therapistName;
  final Color therapistColor;

  const _MessagingScreen({
    required this.therapistName,
    required this.therapistColor,
  });

  @override
  State<_MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<_MessagingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hi! How are you feeling today?',
      'isMe': false,
      'time': '10:30 AM',
    },
    {
      'text': 'I\'m doing better, thanks for asking!',
      'isMe': true,
      'time': '10:32 AM',
    },
    {
      'text': 'That\'s great to hear! What would you like to talk about today?',
      'isMe': false,
      'time': '10:33 AM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isMe': true,
        'time': 'Now',
      });
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.therapistColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('👨‍⚕️', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.therapistName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['isMe'] as bool;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? widget.therapistColor
                          : theme.cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'] as String,
                          style: TextStyle(
                            color: isMe ? Colors.white : theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['time'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: isMe
                                ? Colors.white.withOpacity(0.7)
                                : theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ).animateCardEntrance(index: index),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: theme.dividerColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: theme.cardColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: widget.therapistColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
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
