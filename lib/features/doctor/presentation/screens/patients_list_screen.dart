import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';

class PatientsListScreen extends StatefulWidget {
  const PatientsListScreen({super.key});

  @override
  State<PatientsListScreen> createState() => _PatientsListScreenState();
}

class _PatientsListScreenState extends State<PatientsListScreen> {
  String _searchQuery = '';
  String _filterStatus = 'All'; // All, Active, Inactive

  // Mock data - in production, this would come from a database
  final List<Map<String, dynamic>> _patients = [
    {
      'id': '1',
      'name': 'Sarah Johnson',
      'age': 28,
      'status': 'Active',
      'lastSession': DateTime.now().subtract(const Duration(days: 2)),
      'nextSession': DateTime.now().add(const Duration(days: 5)),
      'sessionsCount': 12,
      'currentMood': 'Improving',
    },
    {
      'id': '2',
      'name': 'Michael Chen',
      'age': 35,
      'status': 'Active',
      'lastSession': DateTime.now().subtract(const Duration(days: 7)),
      'nextSession': DateTime.now().add(const Duration(days: 1)),
      'sessionsCount': 8,
      'currentMood': 'Stable',
    },
    {
      'id': '3',
      'name': 'Emma Davis',
      'age': 42,
      'status': 'Active',
      'lastSession': DateTime.now().subtract(const Duration(days: 14)),
      'nextSession': DateTime.now().add(const Duration(days: 7)),
      'sessionsCount': 24,
      'currentMood': 'Good',
    },
    {
      'id': '4',
      'name': 'James Wilson',
      'age': 31,
      'status': 'Inactive',
      'lastSession': DateTime.now().subtract(const Duration(days: 60)),
      'nextSession': null,
      'sessionsCount': 5,
      'currentMood': 'Unknown',
    },
  ];

  List<Map<String, dynamic>> get _filteredPatients {
    return _patients.where((patient) {
      final matchesSearch = patient['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesFilter =
          _filterStatus == 'All' || patient['status'] == _filterStatus;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Patients'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // Add new patient
            },
          ),
        ],
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
                    hintText: 'Search patients...',
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
                Row(
                  children: [
                    _buildFilterChip('All', colors),
                    const SizedBox(width: 8),
                    _buildFilterChip('Active', colors),
                    const SizedBox(width: 8),
                    _buildFilterChip('Inactive', colors),
                  ],
                ),
              ],
            ),
          ),

          // Patients List
          Expanded(
            child: _filteredPatients.isEmpty
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
                          'No patients found',
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
                    itemCount: _filteredPatients.length,
                    itemBuilder: (context, index) {
                      final patient = _filteredPatients[index];
                      return _buildPatientCard(patient, colors, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, CustomColors colors) {
    final isSelected = _filterStatus == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _filterStatus = label);
      },
      selectedColor: colors.green.withOpacity(0.2),
      checkmarkColor: colors.green,
      labelStyle: TextStyle(
        color: isSelected ? colors.green : colors.onBackground,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildPatientCard(
    Map<String, dynamic> patient,
    CustomColors colors,
    int index,
  ) {
    final isActive = patient['status'] == 'Active';
    
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
            // Navigate to patient detail
          },
          borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isActive
                        ? colors.green.withOpacity(0.1)
                        : colors.onBackground.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: isActive ? colors.green : colors.onBackground.withOpacity(0.5),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Patient Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              patient['name'],
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
                              color: isActive
                                  ? colors.green.withOpacity(0.1)
                                  : colors.onBackground.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              patient['status'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isActive
                                    ? colors.green
                                    : colors.onBackground.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Age: ${patient['age']} • ${patient['sessionsCount']} sessions',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onBackground.withOpacity(0.6),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.sentiment_satisfied,
                            size: 16,
                            color: colors.onBackground.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            patient['currentMood'],
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colors.onBackground.withOpacity(0.7),
                                ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: colors.onBackground.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            patient['nextSession'] != null
                                ? _formatDate(patient['nextSession'])
                                : 'No upcoming session',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colors.onBackground.withOpacity(0.7),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Arrow
                Icon(
                  Icons.chevron_right,
                  color: colors.onBackground.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animateCardEntrance(index: index);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 7) return 'In $difference days';
    return '${date.month}/${date.day}';
  }
}
