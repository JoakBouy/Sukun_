import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/features/clinician/data/models/client_session.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';
import 'package:freud_ai/features/clinician/presentation/screens/assessment_launcher_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/safety_plan_screen.dart';

class ClientDetailScreen extends StatefulWidget {
  final String clientIdentifier;
  const ClientDetailScreen({super.key, required this.clientIdentifier});

  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  final _service = ClinicianService.instance;
  List<ClientSession> _sessions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final sessions = await _service.getSessionsByClient(widget.clientIdentifier);
      if (mounted) setState(() { _sessions = sessions; _loading = false; });
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

  String _scoreDeltaLabel(int? delta) {
    if (delta == null) return '';
    if (delta < 0) return '↓ ${delta.abs()} improved';
    if (delta > 0) return '↑ $delta worsened';
    return '→ no change';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);
    final hasCrisis = _sessions.any((s) => s.crisisFlag);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.clientIdentifier,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
            Text('${_sessions.length} session${_sessions.length != 1 ? 's' : ''}',
                style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
          ],
        ),
        actions: [
          if (hasCrisis)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: CustomColors.primetelRedLight, borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  children: [
                    Icon(Icons.warning, color: CustomColors.primetelRed, size: 14),
                    SizedBox(width: 4),
                    Text('Crisis', style: TextStyle(color: CustomColors.primetelRed, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: CustomColors.primetelRed))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (_) => AssessmentLauncherScreen())).then((_) => _load()),
                          icon: const Icon(Icons.add, color: Colors.white, size: 18),
                          label: const Text('New Assessment', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.primetelRed,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => SafetyPlanScreen(clientIdentifier: widget.clientIdentifier))),
                        icon: const Icon(Icons.shield_outlined, size: 18),
                        label: const Text('Safety Plan'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  if (_sessions.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.assignment_outlined, size: 48, color: colors.onBackground.withOpacity(0.2)),
                          const SizedBox(height: 12),
                          Text('No sessions yet', style: theme.textTheme.titleSmall?.copyWith(
                              color: colors.onBackground.withOpacity(0.4))),
                        ],
                      ),
                    )
                  else ...[
                    // ── Score trend mini chart ──────────────────────────────
                    if (_sessions.length >= 2) ...[
                      _buildTrendSection(colors, theme),
                      const SizedBox(height: 24),
                    ],

                    // ── Timeline ───────────────────────────────────────────
                    Row(
                      children: [
                        Container(width: 4, height: 16,
                            decoration: BoxDecoration(color: CustomColors.primetelRed, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 10),
                        Text('Assessment History', style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold, color: colors.primary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._sessions.asMap().entries.map((e) => _buildTimelineItem(e.value, e.key, colors, theme)),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget _buildTrendSection(CustomColors colors, ThemeData theme) {
    // Group sessions by type
    final byType = <String, List<ClientSession>>{};
    for (final s in _sessions) {
      byType.putIfAbsent(s.assessmentType, () => []).add(s);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Progress', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
          const SizedBox(height: 12),
          ...byType.entries.where((e) => e.value.length >= 2).map((e) {
            final sessions = e.value;
            final latest = sessions[0].score;
            final prev = sessions[1].score;
            final delta = latest - prev;
            final improved = delta < 0;
            final deltaColor = improved ? colors.green : delta > 0 ? CustomColors.primetelRed : colors.grey;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(e.key, style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: latest / 27.0,
                        minHeight: 8,
                        backgroundColor: colors.background,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            _sevColor(sessions[0].severity, colors)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('$latest', style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary)),
                  const SizedBox(width: 6),
                  Icon(
                    improved ? Icons.trending_down : delta > 0 ? Icons.trending_up : Icons.trending_flat,
                    color: deltaColor, size: 16,
                  ),
                  Text(_scoreDeltaLabel(delta), style: TextStyle(fontSize: 11, color: deltaColor)),
                ],
              ),
            );
          }),
        ],
      ),
    ).animateCardEntrance(index: 0);
  }

  Widget _buildTimelineItem(ClientSession session, int index, CustomColors colors, ThemeData theme) {
    final sevColor = _sevColor(session.severity, colors);
    final isFirst = index == 0;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isFirst ? CustomColors.primetelRed : sevColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                  border: Border.all(color: isFirst ? CustomColors.primetelRed : Colors.transparent, width: 2),
                ),
              ),
              Expanded(
                child: Container(width: 2, color: colors.onBackground.withOpacity(0.1)),
              ),
            ],
          ),
          const SizedBox(width: 14),

          // Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                border: session.crisisFlag
                    ? Border.all(color: CustomColors.primetelRed.withOpacity(0.4))
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(session.assessmentType,
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: sevColor.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                        child: Text(session.severity,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: sevColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Score: ${session.score}',
                          style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.7))),
                      const SizedBox(width: 12),
                      Text('· ${session.sessionContext}',
                          style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
                      if (session.crisisFlag) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.warning, color: CustomColors.primetelRed, size: 14),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(_formatDate(session.timestamp),
                      style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.4))),
                  if (session.clinicianNotes != null && session.clinicianNotes!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(session.clinicianNotes!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onBackground.withOpacity(0.7), fontStyle: FontStyle.italic)),
                    ),
                  ],
                ],
              ),
            ).animateCardEntrance(index: index + 2),
          ),
        ],
      ),
    );
  }


  String _formatDate(DateTime dt) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year} · ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
