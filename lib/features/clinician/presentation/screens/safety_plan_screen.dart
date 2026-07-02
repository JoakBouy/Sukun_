import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';

class SafetyPlanScreen extends StatefulWidget {
  final String clientIdentifier;
  const SafetyPlanScreen({super.key, required this.clientIdentifier});

  @override
  State<SafetyPlanScreen> createState() => _SafetyPlanScreenState();
}

class _SafetyPlanScreenState extends State<SafetyPlanScreen> {
  final _service = ClinicianService.instance;
  final _warningSigns = TextEditingController();
  final _internalCoping = TextEditingController();
  final _socialDistractions = TextEditingController();
  final _peopleToContact = TextEditingController();
  final _professionalsToCall = TextEditingController(
      text: 'Primetel Health: +255 XXX XXX XXX\nMuhimbili MH: +255 22 215 0610');
  final _meansRestriction = TextEditingController();
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    final plan = await _service.getSafetyPlan(widget.clientIdentifier);
    if (plan != null && mounted) {
      setState(() {
        _warningSigns.text = plan['warning_signs'] ?? '';
        _internalCoping.text = plan['internal_coping'] ?? '';
        _socialDistractions.text = plan['social_distractions'] ?? '';
        _peopleToContact.text = plan['people_to_contact'] ?? '';
        _professionalsToCall.text = plan['professionals_to_call'] ?? '';
        _meansRestriction.text = plan['means_restriction'] ?? '';
      });
    }
  }

  Future<void> _save() async {
    await _service.saveSafetyPlan(
      clientId: widget.clientIdentifier,
      warningSigns: _warningSigns.text,
      internalCoping: _internalCoping.text,
      socialDistractions: _socialDistractions.text,
      peopleToContact: _peopleToContact.text,
      professionalsToCall: _professionalsToCall.text,
      meansRestriction: _meansRestriction.text,
    );
    if (mounted) {
      setState(() => _saved = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Safety plan saved'),
          backgroundColor: const Color(0xFF9BB068),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  void dispose() {
    _warningSigns.dispose();
    _internalCoping.dispose();
    _socialDistractions.dispose();
    _peopleToContact.dispose();
    _professionalsToCall.dispose();
    _meansRestriction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('Safety Plan — ${widget.clientIdentifier}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save', style: TextStyle(color: CustomColors.primetelRed, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizesManager.padding),
        child: Column(
          children: [
            // Stanley-Brown model header
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: CustomColors.primetelRedLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield, color: CustomColors.primetelRed),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Stanley-Brown Safety Planning Model. Complete collaboratively with the client.',
                      style: theme.textTheme.bodySmall?.copyWith(color: CustomColors.primetelRed),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _planField('1. Warning Signs', 'What thoughts, feelings, or behaviours indicate a crisis may be developing?',
                _warningSigns, Icons.warning_amber_outlined, colors, theme),
            _planField('2. Internal Coping Strategies', 'What can the client do alone to distract themselves?',
                _internalCoping, Icons.self_improvement, colors, theme),
            _planField('3. Social Distractions', 'People and places that provide distraction from the crisis',
                _socialDistractions, Icons.group_outlined, colors, theme),
            _planField('4. People to Contact for Support', 'Name and phone number of trusted support people',
                _peopleToContact, Icons.phone_outlined, colors, theme),
            _planField('5. Professionals & Crisis Lines', 'Professionals and agencies the client can contact in a crisis',
                _professionalsToCall, Icons.local_hospital_outlined, colors, theme),
            _planField('6. Means Restriction', 'Steps to limit access to lethal means (e.g. medication storage)',
                _meansRestriction, Icons.lock_outline, colors, theme),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_alt, color: Colors.white),
                label: const Text('Save Safety Plan',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primetelRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _planField(String label, String hint, TextEditingController controller,
      IconData icon, CustomColors colors, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: CustomColors.primetelRed, size: 18),
              const SizedBox(width: 8),
              Text(label, style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold, color: colors.primary)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: colors.onBackground.withOpacity(0.35), fontSize: 13),
              filled: true,
              fillColor: colors.primaryContainer,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: CustomColors.primetelRed, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
