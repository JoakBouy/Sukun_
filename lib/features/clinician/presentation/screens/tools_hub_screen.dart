import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';
import 'package:freud_ai/features/clinician/presentation/screens/outreach_tracker_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/session_notes_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/batch_session_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/monthly_report_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/technique_library_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/population_insights_screen.dart';

/// Tools hub — the 4th tab. Houses all supporting clinical tools.
class ToolsHubScreen extends StatelessWidget {
  const ToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    final tools = [
      _ToolSection('Documentation', [
        _Tool('Session Notes', 'SOAP notes per client', Icons.edit_note, colors.violet,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SessionNotesScreen()))),
        _Tool('Outreach Log', 'Track community events', Icons.directions_walk, colors.green,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OutreachTrackerScreen()))),
        _Tool('Group Sessions', 'Batch / school programs', Icons.groups, colors.orange,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BatchSessionScreen()))),
        _Tool('Monthly Report', 'Auto-generate impact report', Icons.summarize, CustomColors.primetelRed,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MonthlyReportScreen()))),
      ]),
      _ToolSection('Clinical Support', [
        _Tool('CBT Technique Library', 'Evidence-based therapy tools', Icons.psychology, colors.yellow,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TechniqueLibraryScreen()))),
        _Tool('Population Insights', 'Aggregate data analytics', Icons.insights, colors.violet,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PopulationInsightsScreen()))),
      ]),
    ];

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(width: 4, height: 20,
                decoration: BoxDecoration(color: CustomColors.primetelRed, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 10),
            Text('Tools', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(SizesManager.padding),
        itemCount: tools.length,
        itemBuilder: (ctx, si) {
          final section = tools[si];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (si > 0) const SizedBox(height: 24),
              Text(section.title, style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold, color: colors.onBackground.withOpacity(0.5))),
              const SizedBox(height: 12),
              ...section.tools.asMap().entries.map((e) {
                final tool = e.value;
                return GestureDetector(
                  onTap: tool.onTap,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: tool.color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(tool.icon, color: tool.color, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tool.name, style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold, color: colors.primary)),
                              Text(tool.subtitle, style: theme.textTheme.bodySmall?.copyWith(
                                  color: colors.onBackground.withOpacity(0.5))),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: colors.onBackground.withOpacity(0.25)),
                      ],
                    ),
                  ).animateCardEntrance(index: si * 10 + e.key),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class _ToolSection {
  final String title;
  final List<_Tool> tools;
  const _ToolSection(this.title, this.tools);
}

class _Tool {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _Tool(this.name, this.subtitle, this.icon, this.color, this.onTap);
}
