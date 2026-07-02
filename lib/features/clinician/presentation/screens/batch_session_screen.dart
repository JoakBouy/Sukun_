import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';

class BatchSessionScreen extends StatefulWidget {
  const BatchSessionScreen({super.key});
  @override
  State<BatchSessionScreen> createState() => _BatchSessionScreenState();
}

class _BatchSessionScreenState extends State<BatchSessionScreen> {
  final _service = ClinicianService.instance;
  List<Map<String, dynamic>> _sessions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final sessions = await _service.getGroupSessions();
    if (mounted) setState(() { _sessions = sessions; _loading = false; });
  }

  void _showAdd() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddGroupSheet(onSaved: () { Navigator.pop(context); _load(); }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Group Sessions', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0, backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAdd,
        backgroundColor: colors.orange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Log Group Session', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: CustomColors.primetelRed))
          : _sessions.isEmpty
              ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.groups, size: 56, color: colors.onBackground.withOpacity(0.2)),
                  const SizedBox(height: 12),
                  Text('No group sessions yet', style: theme.textTheme.titleSmall?.copyWith(color: colors.onBackground.withOpacity(0.4))),
                ]))
              : ListView.builder(
                  padding: const EdgeInsets.all(SizesManager.padding),
                  itemCount: _sessions.length,
                  itemBuilder: (ctx, i) {
                    final s = _sessions[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: colors.orange.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                            child: Icon(Icons.groups, color: colors.orange, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s['group_name'] as String, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
                              Text('${s['context']} · ${s['session_type']}', style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.55))),
                              if (s['topics_covered'] != null)
                                Text(s['topics_covered'] as String, maxLines: 1, overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.4))),
                            ],
                          )),
                          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Text('${s['participants']}', style: TextStyle(fontWeight: FontWeight.w800, color: colors.orange, fontSize: 18)),
                            Text('people', style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
                          ]),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}

class _AddGroupSheet extends StatefulWidget {
  final VoidCallback onSaved;
  const _AddGroupSheet({required this.onSaved});

  @override
  State<_AddGroupSheet> createState() => _AddGroupSheetState();
}

class _AddGroupSheetState extends State<_AddGroupSheet> {
  final _service = ClinicianService.instance;
  String _context = 'School Program';
  String _sessionType = 'Psychoeducation';
  final _groupCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _participantsCtrl = TextEditingController(text: '0');
  final _topicsCtrl = TextEditingController();
  final _referralsCtrl = TextEditingController(text: '0');
  final _notesCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
      decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.onBackground.withOpacity(0.2), borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Log Group Session', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _groupCtrl, decoration: InputDecoration(labelText: 'Group / School Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: DropdownButtonFormField<String>(
                value: _context,
                decoration: InputDecoration(labelText: 'Context', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                items: ['School Program', 'Community', 'Workplace', 'Outreach']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (v) => setState(() => _context = v!),
              )),
              const SizedBox(width: 12),
              Expanded(child: DropdownButtonFormField<String>(
                value: _sessionType,
                decoration: InputDecoration(labelText: 'Session Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                items: ['Psychoeducation', 'Screening', 'Workshop', 'Debrief', 'Activity']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (v) => setState(() => _sessionType = v!),
              )),
            ]),
            const SizedBox(height: 12),
            TextField(controller: _locationCtrl, decoration: InputDecoration(labelText: 'Location (optional)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: TextField(controller: _participantsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Participants', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
              const SizedBox(width: 12),
              Expanded(child: TextField(controller: _referralsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Referrals Made', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
            ]),
            const SizedBox(height: 12),
            TextField(controller: _topicsCtrl, decoration: InputDecoration(labelText: 'Topics Covered', hintText: 'e.g. Depression, stress management', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(controller: _notesCtrl, maxLines: 2, decoration: InputDecoration(labelText: 'Notes (optional)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _service.saveGroupSession(
                    groupName: _groupCtrl.text.trim().isEmpty ? 'Group Session' : _groupCtrl.text.trim(),
                    sessionType: _sessionType,
                    context: _context,
                    location: _locationCtrl.text.trim().isEmpty ? null : _locationCtrl.text.trim(),
                    participants: int.tryParse(_participantsCtrl.text) ?? 0,
                    topicsCovered: _topicsCtrl.text.trim(),
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
                child: const Text('Save Group Session', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
