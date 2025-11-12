import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';

class AssessmentConsentScreen extends StatefulWidget {
  final String assessmentType; // 'phq9', 'dass21', 'asq'

  const AssessmentConsentScreen({
    super.key,
    required this.assessmentType,
  });

  @override
  State<AssessmentConsentScreen> createState() => _AssessmentConsentScreenState();
}

class _AssessmentConsentScreenState extends State<AssessmentConsentScreen> {
  bool _hasAgreed = false;

  Map<String, AssessmentInfo> get _assessmentInfo => {
    'phq9': AssessmentInfo(
      title: 'PHQ-9 Depression Scale',
      description: 'A 9-question screening tool for depression symptoms',
      purpose: 'To help identify and monitor depression symptoms over time',
      whatToExpect: 'You will answer 9 questions about how often you\'ve experienced certain symptoms over the past 2 weeks. Each question is rated 0-3.',
      duration: '~3 minutes',
      color: const Color(0xFF9BB068),
    ),
    'dass21': AssessmentInfo(
      title: 'DASS-21 Screening',
      description: 'A 21-question assessment for depression, anxiety, and stress',
      purpose: 'To measure the severity of depression, anxiety, and stress symptoms',
      whatToExpect: 'You will answer 21 questions about your emotional states over the past week. Questions are rated 0-3 based on frequency.',
      duration: '~5 minutes',
      color: const Color(0xFFED7E1C),
    ),
    'asq': AssessmentInfo(
      title: 'ASQ Suicide Risk Assessment',
      description: 'A 4-question screening for suicide risk',
      purpose: 'To identify individuals who may be at risk of suicide and need immediate support',
      whatToExpect: 'You will answer 4 questions about thoughts of death, self-harm, and suicide risk.',
      duration: '~2 minutes',
      color: Colors.red,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final info = _assessmentInfo[widget.assessmentType]!;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Consent'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assessment header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: info.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: info.color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: info.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    info.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF4B3425),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: const Color(0xFF7A6F5C),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        info.duration,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF7A6F5C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Purpose section
            _buildSection(
              title: 'Purpose',
              content: info.purpose,
              icon: Icons.lightbulb_outline,
            ),

            const SizedBox(height: 24),

            // What to expect section
            _buildSection(
              title: 'What to Expect',
              content: info.whatToExpect,
              icon: Icons.info_outline,
            ),

            const SizedBox(height: 24),

            // Important disclaimer
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.amber.shade200,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.amber.shade700,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Important Disclaimer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This assessment is NOT a substitute for professional medical advice, diagnosis, or treatment. The results are for informational purposes only and should not be used as the sole basis for making decisions about your mental health care.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.amber.shade900,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'If you are experiencing a mental health crisis or having thoughts of self-harm, please contact emergency services or a mental health professional immediately.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber.shade900,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Agreement checkbox
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _hasAgreed,
                    onChanged: (value) {
                      setState(() {
                        _hasAgreed = value ?? false;
                      });
                    },
                    activeColor: info.color,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'I understand that this assessment is not medical advice and I agree to proceed with the assessment for informational purposes only.',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF4B3425),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: info.color),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: info.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _hasAgreed ? () => _startAssessment(context) : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: _hasAgreed ? info.color : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Start Assessment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF9BB068),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4B3425),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF4B3425),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _startAssessment(BuildContext context) {
    // Navigate to the appropriate assessment screen
    String routeName;
    switch (widget.assessmentType) {
      case 'phq9':
        routeName = NavigationManager.phq9AssessmentScreen;
        break;
      case 'dass21':
        routeName = NavigationManager.dass21AssessmentScreen;
        break;
      case 'asq':
        routeName = NavigationManager.asqAssessmentScreen;
        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacementNamed(routeName);
  }
}

class AssessmentInfo {
  final String title;
  final String description;
  final String purpose;
  final String whatToExpect;
  final String duration;
  final Color color;

  const AssessmentInfo({
    required this.title,
    required this.description,
    required this.purpose,
    required this.whatToExpect,
    required this.duration,
    required this.color,
  });
}
