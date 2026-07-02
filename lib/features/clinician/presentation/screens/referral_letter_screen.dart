import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralLetterScreen extends StatefulWidget {
  final String clientIdentifier;
  final String assessmentType;
  final int score;
  final String severity;
  final String clinicianName;
  final String? additionalNotes;

  const ReferralLetterScreen({
    super.key,
    required this.clientIdentifier,
    required this.assessmentType,
    required this.score,
    required this.severity,
    required this.clinicianName,
    this.additionalNotes,
  });

  @override
  State<ReferralLetterScreen> createState() => _ReferralLetterScreenState();
}

class _ReferralLetterScreenState extends State<ReferralLetterScreen> {
  final _notesController = TextEditingController();
  final _clinicController = TextEditingController(text: 'Primetel Health — Monduli Clinic');
  String _referralText = '';

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.additionalNotes ?? '';
    _generateLetter();
  }

  void _generateLetter() {
    final text = ClinicianService.instance.generateReferralText(
      clientIdentifier: widget.clientIdentifier,
      assessmentType: widget.assessmentType,
      score: widget.score,
      severity: widget.severity,
      clinicianName: widget.clinicianName,
      clinicName: _clinicController.text,
      additionalNotes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );
    setState(() => _referralText = text);
  }

  @override
  void dispose() {
    _notesController.dispose();
    _clinicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Referral Letter', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_all),
            tooltip: 'Copy letter',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _referralText));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Referral letter copied to clipboard'),
                  backgroundColor: CustomColors.primetelRed,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
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
            // Clinic field
            TextField(
              controller: _clinicController,
              onChanged: (_) => _generateLetter(),
              decoration: InputDecoration(
                labelText: 'Referring Clinic / Location',
                prefixIcon: const Icon(Icons.local_hospital_outlined, color: CustomColors.primetelRed),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: CustomColors.primetelRed, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _notesController,
              onChanged: (_) => _generateLetter(),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Additional clinical notes (optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: CustomColors.primetelRed, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Letter preview
            Row(
              children: [
                Container(width: 4, height: 16,
                    decoration: BoxDecoration(color: CustomColors.primetelRed, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 10),
                Text('Letter Preview', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colors.onBackground.withOpacity(0.1)),
              ),
              child: Text(
                _referralText,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: colors.onBackground,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _referralText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Copied! Paste into SMS, email, or referral form.'),
                      backgroundColor: CustomColors.primetelRed,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                icon: const Icon(Icons.copy_all, color: Colors.white),
                label: const Text('Copy Full Letter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
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
}
