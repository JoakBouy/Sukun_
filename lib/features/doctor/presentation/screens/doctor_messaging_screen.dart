import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

class DoctorMessagingScreen extends StatefulWidget {
  const DoctorMessagingScreen({super.key});

  @override
  State<DoctorMessagingScreen> createState() => _DoctorMessagingScreenState();
}

class _DoctorMessagingScreenState extends State<DoctorMessagingScreen> {
  String _selectedFilter = 'All'; // All, Unread, Patients

  // Mock conversations
  final List<Map<String, dynamic>> _conversations = [
    {
      'id': '1',
      'name': 'Sarah Johnson',
      'role': 'Patient',
      'lastMessage': 'Thank you for the session today!',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      'unread': 2,
      'isOnline': true,
    },
    {
      'id': '2',
      'name': 'Michael Chen',
      'role': 'Patient',
      'lastMessage': 'Can we reschedule tomorrow\'s appointment?',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'unread': 1,
      'isOnline': false,
    },
    {
      'id': '3',
      'name': 'Emma Davis',
      'role': 'Patient',
      'lastMessage': 'I\'ve been practicing the breathing exercises',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      'unread': 0,
      'isOnline': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredConversations {
    return _conversations.where((conv) {
      if (_selectedFilter == 'Unread') return conv['unread'] > 0;
      if (_selectedFilter == 'Patients') return conv['role'] == 'Patient';
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search messages
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(SizesManager.dPadding),
            child: Row(
              children: [
                _buildFilterChip('All', colors),
                const SizedBox(width: 8),
                _buildFilterChip('Unread', colors),
                const SizedBox(width: 8),
                _buildFilterChip('Patients', colors),
              ],
            ),
          ),

          // Conversations List
          Expanded(
            child: _filteredConversations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.message_outlined,
                          size: 64,
                          color: colors.onBackground.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No messages',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colors.onBackground.withOpacity(0.5),
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SizesManager.dPadding,
                    ),
                    itemCount: _filteredConversations.length,
                    itemBuilder: (context, index) {
                      final conversation = _filteredConversations[index];
                      return _buildConversationCard(conversation, colors, index);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // New message
        },
        backgroundColor: colors.green,
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildFilterChip(String label, CustomColors colors) {
    final isSelected = _selectedFilter == label;
    final unreadCount = label == 'Unread'
        ? _conversations.where((c) => c['unread'] > 0).length
        : 0;

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (unreadCount > 0) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$unreadCount',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedFilter = label);
      },
      selectedColor: colors.green.withOpacity(0.2),
      checkmarkColor: colors.green,
      labelStyle: TextStyle(
        color: isSelected ? colors.green : colors.onBackground,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildConversationCard(
    Map<String, dynamic> conversation,
    CustomColors colors,
    int index,
  ) {
    final hasUnread = conversation['unread'] > 0;
    final isOnline = conversation['isOnline'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: hasUnread
            ? colors.green.withOpacity(0.05)
            : colors.primaryContainer,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
        border: hasUnread
            ? Border.all(color: colors.green.withOpacity(0.3), width: 2)
            : null,
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
            // Open conversation - navigate to existing MessagingScreen
            Navigator.pushNamed(context, '/messaging');
          },
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar with online indicator
                Stack(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: colors.green,
                        size: 28,
                      ),
                    ),
                    if (isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.primaryContainer,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),

                // Message Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation['name'],
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: hasUnread
                                        ? FontWeight.bold
                                        : FontWeight.w600,
                                    color: colors.primary,
                                  ),
                            ),
                          ),
                          Text(
                            _formatTimestamp(conversation['timestamp']),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colors.onBackground.withOpacity(0.5),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation['lastMessage'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: hasUnread
                                        ? colors.onBackground
                                        : colors.onBackground.withOpacity(0.6),
                                    fontWeight: hasUnread
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                            ),
                          ),
                          if (hasUnread)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${conversation['unread']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animateCardEntrance(index: index);
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) return '${difference.inMinutes}m';
    if (difference.inHours < 24) return '${difference.inHours}h';
    if (difference.inDays < 7) return '${difference.inDays}d';
    return '${timestamp.month}/${timestamp.day}';
  }
}
