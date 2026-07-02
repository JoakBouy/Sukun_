import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';

class OutreachTrackerScreen extends StatefulWidget {
  const OutreachTrackerScreen({super.key});
  @override
  State<OutreachTrackerScreen> createState() => _OutreachTrackerScreenState();
}

class _OutreachTrackerScreenState extends State<OutreachTrackerScreen> {
  final _service = ClinicianService.instance;
  List<Map<String, dynamic>> _events = [];
  Map<String, dynamic> _stats = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final events = await _service.getOutreachEvents();
      final stats = await _service.getOutreachStats();
      if (mounted) setState(() {
        _events = events.map((e) => e.toMap()).toList();
        _stats = stats;
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showAddEvent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddEventSheet(onSaved: () { Navigator.pop(context); _load(); }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Outreach Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEvent,
        backgroundColor: CustomColors.primetelRed,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Log Event', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: CustomColors.primetelRed))
          : ListView(
              padding: const EdgeInsets.all(SizesManager.padding),
              children: [
                // Stats strip
                Row(
                  children: [
                    _stat('Events', (_stats['total_events'] ?? 0).toString(), colors.green, colors, theme),
                    const SizedBox(width: 10),
                    _stat('Reached', (_stats['total_reached'] ?? 0).toString(), colors.orange, colors, theme),
                    const SizedBox(width: 10),
                    _stat('Referrals', (_stats['total_referrals'] ?? 0).toString(), colors.violet, colors, theme),
                  ],
                ),
                const SizedBox(height: 24),

                if (_events.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Icon(Icons.directions_walk, size: 56, color: colors.onBackground.withOpacity(0.2)),
                        const SizedBox(height: 12),
                        Text('No outreach events yet', style: theme.textTheme.titleSmall?.copyWith(
                            color: colors.onBackground.withOpacity(0.4))),
                        Text('Tap + Log Event to add one', style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onBackground.withOpacity(0.3))),
                      ],
                    ),
                  )
                else
                  ..._events.map((e) => _buildEventCard(e, colors, theme)),
                const SizedBox(height: 100),
              ],
            ),
    );
  }

  Widget _stat(String label, String value, Color color, CustomColors colors, ThemeData theme) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: color)),
            Text(label, style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> e, CustomColors colors, ThemeData theme) {
    final icons = {'Mobile Clinic': Icons.local_hospital, 'School Program': Icons.school,
      'Community': Icons.people, 'Workplace': Icons.business};
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icons[e['event_type']] ?? Icons.event, color: colors.green, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e['event_type'] as String, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
                Text(e['location'] as String, style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.55))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${e['people_reached']} reached', style: TextStyle(fontWeight: FontWeight.bold, color: colors.green, fontSize: 13)),
              Text('${e['referrals_made']} referred', style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddEventSheet extends StatefulWidget {
  final VoidCallback onSaved;
  const _AddEventSheet({required this.onSaved});

  @override
  State<_AddEventSheet> createState() => _AddEventSheetState();
}

class _AddEventSheetState extends State<_AddEventSheet> {
  final _service = ClinicianService.instance;
  String _type = 'Mobile Clinic';
  final _locationCtrl = TextEditingController();
  final _reachedCtrl = TextEditingController(text: '0');
  final _referralsCtrl = TextEditingController(text: '0');
  final _notesCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
      decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.onBackground.withOpacity(0.2), borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Log Outreach Event', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _type,
              decoration: InputDecoration(labelText: 'Event Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              items: ['Mobile Clinic', 'School Program', 'Community', 'Workplace']
                  .map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _type = v!),
            ),
            const SizedBox(height: 12),
            TextField(controller: _locationCtrl, decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _reachedCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'People Reached', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
                const SizedBox(width: 12),
                Expanded(child: TextField(controller: _referralsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Referrals Made', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
              ],
            ),
            const SizedBox(height: 12),
            TextField(controller: _notesCtrl, maxLines: 2, decoration: InputDecoration(labelText: 'Notes (optional)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _service.createOutreachEvent(
                    eventType: _type,
                    location: _locationCtrl.text.trim().isEmpty ? 'Unknown location' : _locationCtrl.text.trim(),
                    peopleReached: int.tryParse(_reachedCtrl.text) ?? 0,
                    referralsMade: int.tryParse(_referralsCtrl.text) ?? 0,
                    notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
                  );
                  widget.onSaved();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primetelRed,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Save Event', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
