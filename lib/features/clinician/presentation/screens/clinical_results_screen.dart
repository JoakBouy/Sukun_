import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';
import 'package:freud_ai/features/clinician/presentation/screens/crisis_protocol_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/safety_plan_screen.dart';
import 'package:freud_ai/features/clinician/presentation/screens/referral_letter_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Psychologist-focused results screen shown after an assessment is completed.
/// Shows clinical interpretation, action checklist, and options to save/refer.
class ClinicalResultsScreen extends StatefulWidget {
  final String clientIdentifier;
  final bool isAnonymous;
  final String? gender;
  final String? ageRange;
  final bool isFirstVisit;
  final String sessionContext;
  final String? subLocation;
  final String assessmentType;
  final int score;
  final String severity;
  final Map<int, String> answers;

  const ClinicalResultsScreen({
    super.key,
    required this.clientIdentifier,
    required this.isAnonymous,
    this.gender,
    this.ageRange,
    required this.isFirstVisit,
    required this.sessionContext,
    this.subLocation,
    required this.assessmentType,
    required this.score,
    required this.severity,
    required this.answers,
  });

  @override
  State<ClinicalResultsScreen> createState() => _ClinicalResultsScreenState();
}

class _ClinicalResultsScreenState extends State<ClinicalResultsScreen> {
  final _service = ClinicianService.instance;
  bool _saved = false;
  bool _saving = false;
  final _notesController = TextEditingController();
  String _clinicianName = '';
  final List<bool> _checklist = [];

  @override
  void initState() {
    super.initState();
    _loadClinicianName();
    _checklist.addAll(List.filled(_actionItems.length, false));
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadClinicianName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _clinicianName = prefs.getString('clinician_name') ?? 'Clinician');
  }

  bool get _isCrisis {
    if (widget.assessmentType == 'ASQ') {
      final yesCount = widget.answers.values.where((a) => a == 'Yes').length;
      return yesCount >= 2;
    }
    if (widget.assessmentType == 'PHQ9' && widget.answers[8] == 'Nearly every day') return true;
    if (widget.assessmentType == 'PCL5' && widget.score >= 50) return true;
    return false;
  }

  Color get _severityColor {
    switch (widget.severity.toLowerCase()) {
      case 'minimal': case 'normal': case 'below threshold': case 'low risk':
        return const Color(0xFF9BB068);
      case 'mild': case 'moderate risk': case 'probable cmd':
        return const Color(0xFFFFBD1A);
      case 'moderate': case 'elevated risk': case 'below clinical threshold':
        return const Color(0xFFED7E1C);
      case 'moderately severe': case 'severe': case 'high risk': case 'moderate ptsd': case 'likely cmd':
        return CustomColors.primetelRed;
      default: return CustomColors.primetelRedDark;
    }
  }

  List<String> get _actionItems {
    final items = <String>[];
    switch (widget.assessmentType) {
      case 'PHQ9':
        if (widget.score >= 5) items.add('Provide psychoeducation about depression');
        if (widget.score >= 10) items.add('Schedule follow-up within 2 weeks');
        if (widget.score >= 15) items.add('Consider referral for pharmacotherapy');
        if (widget.score >= 20) items.add('Urgent psychiatric referral recommended');
        if (widget.answers[8] == 'Nearly every day') {
          items.add('⚠️ Complete safety assessment immediately');
          items.add('Do not leave client alone until safety ensured');
        }
        break;
      case 'GAD7':
        if (widget.score >= 5) items.add('Discuss anxiety management strategies');
        if (widget.score >= 10) items.add('CBT for anxiety — 6-session protocol');
        if (widget.score >= 15) items.add('Consider referral for pharmacotherapy');
        break;
      case 'DASS21':
        if (widget.score >= 10) items.add('Psychoeducation + coping skills session');
        if (widget.score >= 20) items.add('Structured therapy referral recommended');
        items.add('Monitor all three subscales at follow-up');
        break;
      case 'ASQ':
        final yesCount = widget.answers.values.where((a) => a == 'Yes').length;
        if (yesCount >= 1) items.add('Conduct full safety assessment');
        if (yesCount >= 2) items.add('⚠️ Do NOT leave client alone');
        if (yesCount >= 2) items.add('Contact supervisor immediately');
        if (yesCount >= 2) items.add('Complete safety plan before client leaves');
        if (yesCount >= 3) items.add('Emergency referral to district hospital');
        break;
      case 'PCL5':
        items.add('Explain trauma responses in psychoeducation');
        if (widget.score >= 33) items.add('Trauma-focused CBT or EMDR protocol');
        if (widget.score >= 50) items.add('Urgent specialist referral recommended');
        items.add('Screen for comorbid depression (PHQ-9)');
        break;
      case 'SRQ20':
        if (widget.score >= 8) items.add('Probable CMD — further clinical assessment needed');
        if (widget.score >= 8) items.add('Screen with PHQ-9 and GAD-7 for specificity');
        if (widget.answers[16] == 'Yes') items.add('⚠️ Q17 positive — assess suicide risk (ASQ)');
        items.add('Discuss findings with supervisor');
        break;
    }
    if (items.isEmpty) items.add('Continue monitoring — reassess in 4 weeks');
    return items;
  }

  String get _interpretation {
    switch (widget.assessmentType) {
      case 'PHQ9':
        if (widget.score <= 4) return 'No significant depression. Normal range. Monitor as needed.';
        if (widget.score <= 9) return 'Mild depression. Watchful waiting, psychoeducation, and follow-up.';
        if (widget.score <= 14) return 'Moderate depression. CBT or interpersonal therapy indicated.';
        if (widget.score <= 19) return 'Moderately severe depression. Therapy + pharmacotherapy consideration.';
        return 'Severe depression. Urgent intervention and referral required.';
      case 'GAD7':
        if (widget.score <= 4) return 'Minimal anxiety. Reassure and monitor.';
        if (widget.score <= 9) return 'Mild anxiety. Self-help strategies and follow-up.';
        if (widget.score <= 14) return 'Moderate anxiety. CBT and relaxation techniques recommended.';
        return 'Severe anxiety. Structured treatment and possible pharmacotherapy.';
      case 'ASQ':
        final yesCount = widget.answers.values.where((a) => a == 'Yes').length;
        if (yesCount == 0) return 'Low risk. No current suicidal ideation reported.';
        if (yesCount == 1) return 'Moderate risk. Detailed risk assessment needed.';
        return 'HIGH RISK. Immediate safety protocol required. Do not leave client alone.';
      case 'PCL5':
        if (widget.score < 33) return 'Below clinical threshold. Monitor for symptom development.';
        if (widget.score < 50) return 'Moderate PTSD. Trauma-focused intervention recommended.';
        return 'Severe PTSD. Specialist referral and intensive trauma therapy indicated.';
      case 'SRQ20':
        if (widget.score < 8) return 'Below threshold. Normal range for this population.';
        if (widget.score < 12) return 'Probable common mental disorder. Further assessment needed.';
        return 'Likely common mental disorder. Clinical intervention recommended.';
      default:
        return 'Results reviewed. Refer to clinical guidelines for management.';
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await _service.createAndSaveSession(
        clientIdentifier: widget.clientIdentifier,
        isAnonymous: widget.isAnonymous,
        gender: widget.gender,
        ageRange: widget.ageRange,
        isFirstVisit: widget.isFirstVisit,
        sessionContext: widget.sessionContext,
        subLocation: widget.subLocation,
        assessmentType: widget.assessmentType,
        score: widget.score,
        severity: widget.severity,
        answers: widget.answers,
        clinicianNotes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        crisisFlag: _isCrisis,
        referralMade: null,
      );
      setState(() { _saved = true; _saving = false; });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Session saved to client record'),
            backgroundColor: const Color(0xFF9BB068),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('${widget.assessmentType} Results', style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copy summary',
            onPressed: () {
              final text = '${widget.assessmentType} | ${widget.clientIdentifier} | Score: ${widget.score} | ${widget.severity}';
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizesManager.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Crisis Banner ──────────────────────────────────────────────
            if (_isCrisis)
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CrisisProtocolScreen())),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBEAEA),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: CustomColors.primetelRed, width: 2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_rounded, color: CustomColors.primetelRed, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CRISIS RISK DETECTED', style: TextStyle(
                              fontWeight: FontWeight.w900, color: CustomColors.primetelRed, fontSize: 14)),
                            Text('Tap to open crisis protocol →', style: TextStyle(
                              color: CustomColors.primetelRed.withOpacity(0.7), fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().shimmer(duration: 2.seconds, color: CustomColors.primetelRed.withOpacity(0.2)),
              ),

            // ── Score Card ─────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_severityColor.withOpacity(0.12), _severityColor.withOpacity(0.04)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _severityColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text('${widget.assessmentType} Score',
                      style: theme.textTheme.titleSmall?.copyWith(color: colors.onBackground.withOpacity(0.6))),
                  const SizedBox(height: 8),
                  Text(widget.score.toString(),
                      style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: _severityColor)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(color: _severityColor, borderRadius: BorderRadius.circular(20)),
                    child: Text(widget.severity,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const SizedBox(height: 12),
                  // Client info
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(widget.isAnonymous ? Icons.lock : Icons.person,
                            size: 14, color: colors.onBackground.withOpacity(0.5)),
                        const SizedBox(width: 6),
                        Text(widget.clientIdentifier,
                            style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.7))),
                        const SizedBox(width: 8),
                        Text('· ${widget.sessionContext}',
                            style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),
            const SizedBox(height: 20),

            // ── Clinical Interpretation ────────────────────────────────────
            _section('Clinical Interpretation', colors, theme),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(_interpretation,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onBackground, height: 1.6)),
            ).animateCardEntrance(index: 1),
            const SizedBox(height: 20),

            // ── Action Checklist ───────────────────────────────────────────
            _section('Clinical Action Checklist', colors, theme),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: _actionItems.asMap().entries.map((e) {
                  final isChecked = e.key < _checklist.length ? _checklist[e.key] : false;
                  return CheckboxListTile(
                    value: isChecked,
                    activeColor: CustomColors.primetelRed,
                    onChanged: (v) => setState(() {
                      if (e.key < _checklist.length) _checklist[e.key] = v ?? false;
                    }),
                    title: Text(e.value,
                        style: theme.textTheme.bodySmall?.copyWith(
                          decoration: isChecked ? TextDecoration.lineThrough : null,
                          color: isChecked ? colors.onBackground.withOpacity(0.4) : colors.onBackground,
                        )),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  );
                }).toList(),
              ),
            ).animateCardEntrance(index: 2),
            const SizedBox(height: 20),

            // ── Clinician Notes ────────────────────────────────────────────
            _section('Session Notes', colors, theme),
            const SizedBox(height: 10),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add clinical observations, context, or follow-up plan...',
                filled: true,
                fillColor: colors.primaryContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: CustomColors.primetelRed, width: 2),
                ),
              ),
            ).animateCardEntrance(index: 3),
            const SizedBox(height: 24),

            // ── Action Buttons ─────────────────────────────────────────────
            if (!_saved)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saving ? null : _save,
                  icon: _saving
                      ? const SizedBox(width: 16, height: 16,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Icon(Icons.save_alt, color: Colors.white),
                  label: Text(_saving ? 'Saving...' : 'Save to Client Record',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primetelRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms)
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF9BB068).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF9BB068).withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, color: Color(0xFF9BB068)),
                    const SizedBox(width: 8),
                    Text('Saved to ${widget.clientIdentifier}\'s record',
                        style: const TextStyle(color: Color(0xFF9BB068), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SafetyPlanScreen(clientIdentifier: widget.clientIdentifier))),
                    icon: const Icon(Icons.shield_outlined),
                    label: const Text('Safety Plan'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ReferralLetterScreen(
                          clientIdentifier: widget.clientIdentifier,
                          assessmentType: widget.assessmentType,
                          score: widget.score,
                          severity: widget.severity,
                          clinicianName: _clinicianName,
                        ))),
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Refer'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ).animateCardEntrance(index: 5),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, CustomColors colors, ThemeData theme) {
    return Row(
      children: [
        Container(width: 4, height: 16, decoration: BoxDecoration(color: CustomColors.primetelRed, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 10),
        Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
      ],
    );
  }
}
