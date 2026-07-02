import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';

class PopulationInsightsScreen extends StatefulWidget {
  const PopulationInsightsScreen({super.key});
  @override
  State<PopulationInsightsScreen> createState() => _PopulationInsightsScreenState();
}

class _PopulationInsightsScreenState extends State<PopulationInsightsScreen> {
  List<Map<String, dynamic>> _distribution = [];
  Map<String, dynamic> _stats = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final dist = await ClinicianService.instance.getSeverityDistribution();
      final stats = await ClinicianService.instance.getDashboardStats();
      if (mounted) setState(() { _distribution = dist; _stats = stats; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Color _sevColor(String severity, CustomColors colors) {
    switch (severity.toLowerCase()) {
      case 'minimal': case 'normal': case 'below threshold': return colors.green;
      case 'mild': return colors.yellow;
      case 'moderate': return colors.orange;
      default: return CustomColors.primetelRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    // Group distribution by assessment type
    final byType = <String, List<Map<String, dynamic>>>{};
    for (final row in _distribution) {
      final type = row['assessment_type'] as String;
      byType.putIfAbsent(type, () => []).add(row);
    }

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Population Insights', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0, backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () { setState(() => _loading = true); _load(); }),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: CustomColors.primetelRed))
          : ListView(
              padding: const EdgeInsets.all(SizesManager.padding),
              children: [
                // Summary stats
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFC82828), Color(0xFF8B1A1A)],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total clients in system', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70)),
                      Text((_stats['total_clients'] ?? 0).toString(),
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
                      const SizedBox(height: 8),
                      Text('Last 90 days — ${_distribution.fold<int>(0, (sum, d) => sum + (d['count'] as int))} assessments recorded',
                          style: theme.textTheme.labelSmall?.copyWith(color: Colors.white60)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                if (_distribution.isEmpty)
                  Center(child: Column(children: [
                    Icon(Icons.insights, size: 56, color: colors.onBackground.withOpacity(0.2)),
                    const SizedBox(height: 12),
                    Text('No data yet', style: theme.textTheme.titleSmall?.copyWith(color: colors.onBackground.withOpacity(0.4))),
                    Text('Complete assessments to see population insights', style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.3)), textAlign: TextAlign.center),
                  ]))
                else
                  ...byType.entries.map((entry) {
                    final type = entry.key;
                    final rows = entry.value;
                    final total = rows.fold<int>(0, (sum, r) => sum + (r['count'] as int));

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(type, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
                          Text('$total assessments · last 90 days',
                              style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
                          const SizedBox(height: 14),
                          ...rows.map((row) {
                            final severity = row['severity'] as String;
                            final count = row['count'] as int;
                            final pct = total > 0 ? count / total : 0.0;
                            final sevColor = _sevColor(severity, colors);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(severity, style: TextStyle(fontSize: 13, color: sevColor, fontWeight: FontWeight.w600)),
                                      Text('$count (${(pct * 100).toInt()}%)',
                                          style: TextStyle(fontSize: 12, color: colors.onBackground.withOpacity(0.6))),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: pct,
                                      minHeight: 8,
                                      backgroundColor: colors.background,
                                      valueColor: AlwaysStoppedAnimation<Color>(sevColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }),
                const SizedBox(height: 40),
              ],
            ),
    );
  }
}
