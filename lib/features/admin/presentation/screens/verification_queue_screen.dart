import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/features/admin/data/models/license_application.dart';

class VerificationQueueScreen extends StatefulWidget {
  const VerificationQueueScreen({super.key});

  @override
  State<VerificationQueueScreen> createState() => _VerificationQueueScreenState();
}

class _VerificationQueueScreenState extends State<VerificationQueueScreen> {
  String _filterStatus = 'Pending'; // Pending, All, Verified, Rejected

  // Mock data
  final List<LicenseApplication> _applications = [
    LicenseApplication(
      id: '1',
      userId: 'user1',
      doctorName: 'Dr. Emily Rodriguez',
      email: 'emily.rodriguez@example.com',
      licenseNumber: 'PSY-12345',
      specialization: 'Clinical Psychology',
      yearsOfExperience: 8,
      status: 'pending',
      documentUrl: 'https://example.com/license1.pdf',
      submittedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    LicenseApplication(
      id: '2',
      userId: 'user2',
      doctorName: 'Dr. Marcus Thompson',
      email: 'marcus.thompson@example.com',
      licenseNumber: 'PSY-67890',
      specialization: 'Cognitive Behavioral Therapy',
      yearsOfExperience: 12,
      status: 'pending',
      documentUrl: 'https://example.com/license2.pdf',
      submittedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    LicenseApplication(
      id: '3',
      userId: 'user3',
      doctorName: 'Dr. Sarah Kim',
      email: 'sarah.kim@example.com',
      licenseNumber: 'PSY-11111',
      specialization: 'Family Therapy',
      yearsOfExperience: 6,
      status: 'verified',
      submittedAt: DateTime.now().subtract(const Duration(days: 10)),
      reviewedAt: DateTime.now().subtract(const Duration(days: 9)),
    ),
  ];

  List<LicenseApplication> get _filteredApplications {
    if (_filterStatus == 'All') return _applications;
    return _applications
        .where((app) => app.status == _filterStatus.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('License Verification'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(SizesManager.dPadding),
            child: Row(
              children: [
                _buildFilterChip('Pending', colors),
                const SizedBox(width: 8),
                _buildFilterChip('All', colors),
                const SizedBox(width: 8),
                _buildFilterChip('Verified', colors),
                const SizedBox(width: 8),
                _buildFilterChip('Rejected', colors),
              ],
            ),
          ),

          // Applications List
          Expanded(
            child: _filteredApplications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 64,
                          color: colors.onBackground.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No applications found',
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
                    itemCount: _filteredApplications.length,
                    itemBuilder: (context, index) {
                      final application = _filteredApplications[index];
                      return _buildApplicationCard(application, colors, index);
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

  Widget _buildApplicationCard(
    LicenseApplication application,
    CustomColors colors,
    int index,
  ) {
    Color statusColor;
    IconData statusIcon;

    switch (application.status) {
      case 'verified':
        statusColor = colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = colors.orange;
        statusIcon = Icons.pending;
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.doctorName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        application.email,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onBackground.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 16, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        application.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Details
            _buildDetailRow(
              Icons.badge,
              'License: ${application.licenseNumber}',
              colors,
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              Icons.psychology,
              application.specialization,
              colors,
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              Icons.work,
              '${application.yearsOfExperience} years experience',
              colors,
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              Icons.calendar_today,
              'Submitted ${_formatDate(application.submittedAt)}',
              colors,
            ),

            // View Document Button
            if (application.documentUrl != null) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _viewDocument(application.documentUrl!),
                icon: const Icon(Icons.description),
                label: const Text('View License Document'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.violet,
                  side: BorderSide(color: colors.violet),
                ),
              ),
            ],

            // Actions (only for pending)
            if (application.isPending) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _rejectApplication(application),
                      icon: const Icon(Icons.close),
                      label: const Text('Reject'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _approveApplication(application),
                      icon: const Icon(Icons.check),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    ).animateCardEntrance(index: index);
  }

  Widget _buildDetailRow(IconData icon, String text, CustomColors colors) {
    return Row(
      children: [
        Icon(icon, size: 16, color: colors.onBackground.withOpacity(0.5)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onBackground.withOpacity(0.7),
                ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) return 'today';
    if (difference.inDays == 1) return 'yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    return '${date.month}/${date.day}/${date.year}';
  }

  void _approveApplication(LicenseApplication application) {
    // In production, this would update the database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Approved ${application.doctorName}'),
        backgroundColor: Theme.of(context).extension<CustomColors>()!.green,
      ),
    );
  }

  void _rejectApplication(LicenseApplication application) {
    // In production, this would show a dialog to enter rejection reason
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application rejected'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _viewDocument(String documentUrl) {
    // In production, this would open the document in a viewer or browser
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening document: $documentUrl'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
