import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Header with notification count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: const Color(0xFF4B3425),
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.60,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFED2C2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      '+11',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFFD631A),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.20,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 64,
                height: 64,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: const Color(0xFFD4C1B9),
                    ),
                    borderRadius: BorderRadius.circular(1234),
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 32,
                  color: Color(0xFF4B3425),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Earlier This Day section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Earlier This Day',
                    style: TextStyle(
                      color: const Color(0xFF4B3425),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.18,
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: Color(0xFF4B3425)),
                ],
              ),
              const SizedBox(height: 12),

              // Notification cards
              _buildNotificationCard(
                icon: Icons.message,
                iconColor: const Color(0xFF9BB068),
                title: 'Message from Dr Freud AI!',
                subtitle: '52 Total Unread Messages ⚠',
                time: '2h ago',
              ),

              const SizedBox(height: 8),

              _buildNotificationCard(
                icon: Icons.book,
                iconColor: const Color(0xFFA18EFF),
                title: 'Journal Incomplete!',
                subtitle: 'It\'s Reflection Time! ✍',
                time: '4h ago',
                showProgress: true,
                progressValue: 8,
                progressTotal: 32,
              ),

              const SizedBox(height: 8),

              _buildNotificationCard(
                icon: Icons.spa,
                iconColor: const Color(0xFF926247),
                title: 'Exercise Complete!',
                subtitle: '22m Breathing Done. 🧘‍♀️',
                time: '6h ago',
              ),

              const SizedBox(height: 8),

              _buildNotificationCard(
                icon: Icons.analytics,
                iconColor: const Color(0xFFFFCE5B),
                title: 'Mental Health Data is Here.',
                subtitle: 'Your Monthly Mental Analysis is here.',
                time: '1d ago',
                attachment: 'Shinomiya Data.pdf',
              ),

              const SizedBox(height: 8),

              _buildNotificationCard(
                icon: Icons.sentiment_satisfied,
                iconColor: const Color(0xFF9BB068),
                title: 'Mood Improved.',
                subtitle: 'Neutral → Happy',
                time: '2d ago',
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Last Week section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Last Week',
                    style: TextStyle(
                      color: const Color(0xFF4B3425),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.18,
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: Color(0xFF4B3425)),
                ],
              ),
              const SizedBox(height: 12),

              _buildNotificationCard(
                icon: Icons.trending_down,
                iconColor: const Color(0xFFFE804B),
                title: 'Stress Decreased.',
                subtitle: 'Stress Level is now 3.',
                time: '3d ago',
                showStressBar: true,
              ),

              const SizedBox(height: 8),

              _buildNotificationCard(
                icon: Icons.psychology,
                iconColor: const Color(0xFF926247),
                title: 'Dr Freud Recommendations.',
                subtitle: '48 Health Recommendations',
                time: '5d ago',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    String? attachment,
    bool showProgress = false,
    int? progressValue,
    int? progressTotal,
    bool showStressBar = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x0C4B3425),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 64,
                height: 64,
                decoration: ShapeDecoration(
                  color: iconColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF4B3425),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xA31F160F),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.14,
                      ),
                    ),

                    // Progress bar
                    if (showProgress && progressValue != null && progressTotal != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 6,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFE7DDD8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1234),
                                ),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progressValue / progressTotal,
                                child: Container(
                                  decoration: ShapeDecoration(
                                    color: iconColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1234),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$progressValue/$progressTotal',
                            style: const TextStyle(
                              color: Color(0xFF4B3425),
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Stress bar
                    if (showStressBar) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Expanded(
                            child: Container(
                              height: 6,
                              margin: EdgeInsets.only(right: index < 4 ? 4 : 0),
                              decoration: ShapeDecoration(
                                color: index < 3 ? iconColor : const Color(0xFFE7DDD8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1234),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Stress Level is now 3.',
                        style: TextStyle(
                          color: Color(0xA31F160F),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],

                    // Attachment
                    if (attachment != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF4B3425),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.attach_file,
                              size: 16,
                              color: Color(0xFF4B3425),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              attachment,
                              style: const TextStyle(
                                color: Color(0xA31F160F),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      color: Color(0xA31F160F),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFE804B),
                      shape: OvalBorder(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
