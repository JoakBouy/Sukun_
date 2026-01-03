import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String _searchQuery = '';
  String _filterRole = 'All'; // All, Patient, Doctor, Admin

  // Mock data
  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'Sarah Johnson',
      'email': 'sarah.j@example.com',
      'role': 'Patient',
      'status': 'Active',
      'joinedDate': DateTime.now().subtract(const Duration(days: 120)),
      'lastActive': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'id': '2',
      'name': 'Dr. Emily Rodriguez',
      'email': 'emily.rodriguez@example.com',
      'role': 'Doctor',
      'status': 'Active',
      'joinedDate': DateTime.now().subtract(const Duration(days: 200)),
      'lastActive': DateTime.now().subtract(const Duration(minutes: 30)),
    },
    {
      'id': '3',
      'name': 'Michael Chen',
      'email': 'michael.chen@example.com',
      'role': 'Patient',
      'status': 'Active',
      'joinedDate': DateTime.now().subtract(const Duration(days: 45)),
      'lastActive': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '4',
      'name': 'Admin User',
      'email': 'admin@sukun.com',
      'role': 'Admin',
      'status': 'Active',
      'joinedDate': DateTime.now().subtract(const Duration(days: 365)),
      'lastActive': DateTime.now(),
    },
    {
      'id': '5',
      'name': 'Dr. Marcus Thompson',
      'email': 'marcus.t@example.com',
      'role': 'Doctor',
      'status': 'Suspended',
      'joinedDate': DateTime.now().subtract(const Duration(days: 150)),
      'lastActive': DateTime.now().subtract(const Duration(days: 30)),
    },
  ];

  List<Map<String, dynamic>> get _filteredUsers {
    return _users.where((user) {
      final matchesSearch = user['name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          user['email'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _filterRole == 'All' || user['role'] == _filterRole;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Search and Filter
          Padding(
            padding: const EdgeInsets.all(SizesManager.dPadding),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: colors.primaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All', colors),
                      const SizedBox(width: 8),
                      _buildFilterChip('Patient', colors),
                      const SizedBox(width: 8),
                      _buildFilterChip('Doctor', colors),
                      const SizedBox(width: 8),
                      _buildFilterChip('Admin', colors),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Statistics Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizesManager.dPadding),
            child: Row(
              children: [
                _buildStatCard('Total Users', '${_users.length}', colors.violet, colors),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Active',
                  '${_users.where((u) => u['status'] == 'Active').length}',
                  colors.green,
                  colors,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Doctors',
                  '${_users.where((u) => u['role'] == 'Doctor').length}',
                  colors.orange,
                  colors,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Users List
          Expanded(
            child: _filteredUsers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: colors.onBackground.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No users found',
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
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = _filteredUsers[index];
                      return _buildUserCard(user, colors, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, CustomColors colors) {
    final isSelected = _filterRole == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _filterRole = label);
      },
      selectedColor: colors.violet.withOpacity(0.2),
      checkmarkColor: colors.violet,
      labelStyle: TextStyle(
        color: isSelected ? colors.violet : colors.onBackground,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, CustomColors colors) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: colors.onBackground.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(
    Map<String, dynamic> user,
    CustomColors colors,
    int index,
  ) {
    final isActive = user['status'] == 'Active';
    Color roleColor;

    switch (user['role']) {
      case 'Doctor':
        roleColor = colors.green;
        break;
      case 'Admin':
        roleColor = colors.violet;
        break;
      default:
        roleColor = colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // View user details
          },
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: roleColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    user['role'] == 'Doctor'
                        ? Icons.medical_services
                        : user['role'] == 'Admin'
                            ? Icons.admin_panel_settings
                            : Icons.person,
                    color: roleColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user['name'],
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colors.primary,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: roleColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              user['role'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: roleColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['email'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onBackground.withOpacity(0.6),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: isActive ? colors.green : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user['status'],
                            style: TextStyle(
                              fontSize: 12,
                              color: isActive ? colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: colors.onBackground.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatLastActive(user['lastActive']),
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.onBackground.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Menu
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: colors.onBackground.withOpacity(0.5),
                  ),
                  onSelected: (value) {
                    _handleUserAction(value, user);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'view',
                      child: Row(
                        children: [
                          Icon(Icons.visibility),
                          SizedBox(width: 8),
                          Text('View Details'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Edit User'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: isActive ? 'suspend' : 'activate',
                      child: Row(
                        children: [
                          Icon(isActive ? Icons.block : Icons.check_circle),
                          const SizedBox(width: 8),
                          Text(isActive ? 'Suspend' : 'Activate'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).animateCardEntrance(index: index);
  }

  String _formatLastActive(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${date.month}/${date.day}';
  }

  void _handleUserAction(String action, Map<String, dynamic> user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action: ${user['name']}'),
      ),
    );
  }
}
