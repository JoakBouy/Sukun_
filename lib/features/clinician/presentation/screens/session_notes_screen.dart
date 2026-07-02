import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';

class SessionNotesScreen extends StatefulWidget {
  const SessionNotesScreen({super.key});
  @override
  State<SessionNotesScreen> createState() => _SessionNotesScreenState();
}

class _SessionNotesScreenState extends State<SessionNotesScreen> {
  final _service = ClinicianService.instance;
  List<Map<String, dynamic>> _clientNotes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final notes = await _service.getAllClientNotes();
      if (mounted) setState(() { _clientNotes = notes; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showNewNote() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _NewNoteSheet(onSaved: () { Navigator.pop(context); _load(); }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Session Notes', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0, backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showNewNote,
        backgroundColor: colors.violet,
        icon: const Icon(Icons.edit_note, color: Colors.white),
        label: const Text('New Note', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: CustomColors.primetelRed))
          : _clientNotes.isEmpty
              ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.edit_note, size: 56, color: colors.onBackground.withOpacity(0.2)),
                  const SizedBox(height: 12),
                  Text('No notes yet', style: theme.textTheme.titleSmall?.copyWith(color: colors.onBackground.withOpacity(0.4))),
                  Text('Tap + New Note to write a SOAP note', style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.3))),
                ]))
              : ListView.builder(
                  padding: const EdgeInsets.all(SizesManager.padding),
                  itemCount: _clientNotes.length,
                  itemBuilder: (ctx, i) {
                    final note = _clientNotes[i];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => _ClientNotesDetail(clientId: note['client_identifier'] as String),
                      )),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: colors.violet.withOpacity(0.15),
                              child: Text((note['client_identifier'] as String)[0].toUpperCase(),
                                  style: TextStyle(color: colors.violet, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(note['client_identifier'] as String,
                                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
                                Text('${note['note_count']} note${(note['note_count'] as int) != 1 ? 's' : ''}',
                                    style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
                              ],
                            )),
                            Icon(Icons.chevron_right, color: colors.onBackground.withOpacity(0.3)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class _ClientNotesDetail extends StatefulWidget {
  final String clientId;
  const _ClientNotesDetail({required this.clientId});

  @override
  State<_ClientNotesDetail> createState() => _ClientNotesDetailState();
}

class _ClientNotesDetailState extends State<_ClientNotesDetail> {
  List<Map<String, dynamic>> _notes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final notes = await ClinicianService.instance.getSoapNotes(widget.clientId);
    if (mounted) setState(() { _notes = notes; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(widget.clientId, style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0, backgroundColor: Colors.transparent,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: CustomColors.primetelRed))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notes.length,
              itemBuilder: (_, i) {
                final note = _notes[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                        child: Text(_formatDate(note['created_at'] as int),
                            style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
                      ),
                      ...['subjective', 'objective', 'assessment', 'plan'].map((field) {
                        final val = note[field] as String?;
                        if (val == null || val.isEmpty) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(field.toUpperCase(), style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 11, color: colors.violet)),
                              const SizedBox(height: 4),
                              Text(val, style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground, height: 1.5)),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 4),
                    ],
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(int ms) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year} · ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _NewNoteSheet extends StatefulWidget {
  final VoidCallback onSaved;
  const _NewNoteSheet({required this.onSaved});

  @override
  State<_NewNoteSheet> createState() => _NewNoteSheetState();
}

class _NewNoteSheetState extends State<_NewNoteSheet> {
  final _clientCtrl = TextEditingController();
  final _sCtrl = TextEditingController();
  final _oCtrl = TextEditingController();
  final _aCtrl = TextEditingController();
  final _pCtrl = TextEditingController();

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
            Text('SOAP Note', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _clientCtrl, decoration: InputDecoration(labelText: 'Client Identifier', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            _soapField('S — Subjective', 'What the client reported...', _sCtrl, colors.violet),
            _soapField('O — Objective', 'Clinician observations, MSE findings...', _oCtrl, colors.orange),
            _soapField('A — Assessment', 'Clinical formulation and diagnosis impression...', _aCtrl, CustomColors.primetelRed),
            _soapField('P — Plan', 'Next steps, homework, referrals, follow-up...', _pCtrl, colors.green),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await ClinicianService.instance.saveSoapNote(
                    clientId: _clientCtrl.text.trim().isEmpty ? 'Unknown Client' : _clientCtrl.text.trim(),
                    subjective: _sCtrl.text.trim(),
                    objective: _oCtrl.text.trim(),
                    assessment: _aCtrl.text.trim(),
                    plan: _pCtrl.text.trim(),
                  );
                  widget.onSaved();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primetelRed,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Save Note', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _soapField(String label, String hint, TextEditingController ctrl, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: color.withOpacity(0.05),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: color.withOpacity(0.3))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: color, width: 2)),
            ),
          ),
        ],
      ),
    );
  }
}
