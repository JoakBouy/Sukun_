import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/clinician/data/services/clinician_service.dart';

class CrisisProtocolScreen extends StatefulWidget {
  final String? clientIdentifier;
  const CrisisProtocolScreen({super.key, this.clientIdentifier});

  @override
  State<CrisisProtocolScreen> createState() => _CrisisProtocolScreenState();
}

class _CrisisProtocolScreenState extends State<CrisisProtocolScreen> {
  int _currentStep = 0;

  final _steps = [
    _Step('Stay With Client', Icons.people,
      'Do NOT leave the person alone. Maintain a calm, non-judgmental presence. Remove any means of self-harm from the immediate environment.',
      Color(0xFFC82828)),
    _Step('Establish Safety', Icons.shield,
      'Ask directly: "Are you thinking of ending your life right now?" Listen actively. Validate their feelings without minimizing the crisis.',
      Color(0xFFED7E1C)),
    _Step('Contact Supervisor', Icons.phone,
      'Immediately notify your clinical supervisor or team lead. Document the time of notification. Do not manage a high-risk crisis alone.',
      Color(0xFFFFBD1A)),
    _Step('Complete Safety Plan', Icons.assignment,
      'Work with the client to complete a safety plan before they leave. Identify warning signs, coping strategies, support contacts, and means restriction agreement.',
      Color(0xFF9BB068)),
    _Step('Referral Decision', Icons.local_hospital,
      'Assess whether inpatient hospitalization is required. Contact Muhimbili National Hospital (MNH) Mental Health Department or local district hospital if emergency admission is needed.',
      Color(0xFFA694F5)),
    _Step('Document & Follow Up', Icons.edit_document,
      'Record the incident in the client\'s file with time, assessment, actions taken, and outcome. Schedule follow-up within 24-48 hours. Notify Primetel supervisor.',
      Color(0xFF0B7B6B)),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: CustomColors.primetelRed,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.white, size: 22),
            SizedBox(width: 8),
            Text('Crisis Protocol', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Red urgency banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: const Color(0xFFFBEAEA),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: CustomColors.primetelRed, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.clientIdentifier != null
                        ? 'Active crisis for: ${widget.clientIdentifier}'
                        : 'Follow each step carefully. Do not skip.',
                    style: const TextStyle(
                      color: CustomColors.primetelRed,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Steps
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: Column(
                children: [
                  ..._steps.asMap().entries.map((e) {
                    final step = e.value;
                    final i = e.key;
                    final isDone = i < _currentStep;
                    final isActive = i == _currentStep;

                    return GestureDetector(
                      onTap: () => setState(() => _currentStep = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isActive
                              ? step.color.withOpacity(0.08)
                              : isDone
                                  ? const Color(0xFF9BB068).withOpacity(0.06)
                                  : colors.primaryContainer,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isActive
                                ? step.color
                                : isDone
                                    ? const Color(0xFF9BB068).withOpacity(0.5)
                                    : Colors.transparent,
                            width: isActive ? 2 : 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Step number / check
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isDone
                                      ? const Color(0xFF9BB068)
                                      : isActive
                                          ? step.color
                                          : colors.onBackground.withOpacity(0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: isDone
                                    ? const Icon(Icons.check, color: Colors.white, size: 22)
                                    : isActive
                                        ? Icon(step.icon, color: Colors.white, size: 22)
                                        : Center(
                                            child: Text('${i + 1}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: colors.onBackground.withOpacity(0.4),
                                                )),
                                          ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Step ${i + 1}: ${step.title}',
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isActive ? step.color : colors.primary,
                                      ),
                                    ),
                                    if (isActive) ...[
                                      const SizedBox(height: 8),
                                      Text(step.description,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: colors.onBackground.withOpacity(0.75),
                                            height: 1.6,
                                          )),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  // Emergency contacts
                  const SizedBox(height: 8),
                  _ContactCard('Muhimbili National Hospital (MNH)', '+255 22 215 0610', colors, theme),
                  _ContactCard('Primetel Health Emergency Line', '+255 XXX XXX XXX', colors, theme),
                  _ContactCard('District Mental Health Officer', 'Contact via supervisor', colors, theme),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Bottom navigation
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            color: colors.primaryContainer,
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      child: const Text('← Previous'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentStep < _steps.length - 1
                        ? () => setState(() => _currentStep++)
                        : () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentStep < _steps.length - 1
                          ? _steps[_currentStep].color
                          : const Color(0xFF9BB068),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(
                      _currentStep < _steps.length - 1 ? 'Next Step →' : 'Done',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _ContactCard(String name, String contact, CustomColors colors, ThemeData theme) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: colors.primaryContainer,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: CustomColors.primetelRed.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.phone, color: CustomColors.primetelRed, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: colors.primary)),
              Text(contact, style: theme.textTheme.labelSmall?.copyWith(color: CustomColors.primetelRed)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Clipboard.setData(ClipboardData(text: contact)),
          child: Icon(Icons.copy, size: 16, color: colors.onBackground.withOpacity(0.3)),
        ),
      ],
    ),
  );
}

class _Step {
  final String title;
  final IconData icon;
  final String description;
  final Color color;
  const _Step(this.title, this.icon, this.description, this.color);
}
