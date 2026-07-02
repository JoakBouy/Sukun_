import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/assessment_question_card.dart';

class ASQAssessmentScreen extends StatefulWidget {
  final bool isClinicianFlow;
  const ASQAssessmentScreen({super.key, this.isClinicianFlow = false});

  @override
  State<ASQAssessmentScreen> createState() => _ASQAssessmentScreenState();
}

class _ASQAssessmentScreenState extends State<ASQAssessmentScreen> {
  final Map<int, String> _answers = {};
  late PageController _pageController;
  int _currentQuestion = 0;

  final List<String> _questions = [
    'In the past few weeks, have you wished you were dead or wished you could go to sleep and not wake up?',
    'In the past few weeks, have you been thinking about how you might hurt yourself?',
    'Have you ever tried to hurt yourself?',
    'Are you right now having thoughts about hurting yourself?',
  ];

  final List<String> _options = ['No', 'Yes'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _getRiskLevel() {
    int riskCount = 0;
    for (var answer in _answers.values) {
      if (answer == 'Yes') riskCount++;
    }
    return riskCount;
  }

  String _getRiskDescription(int level) {
    if (level == 0) return 'Low Risk';
    if (level == 1) return 'Moderate Risk';
    if (level == 2) return 'Elevated Risk';
    return 'High Risk';
  }

  Color _getRiskColor(int level) {
    if (level == 0) return const Color(0xFF9BB068);
    if (level == 1) return const Color(0xFFFFBD1A);
    if (level == 2) return const Color(0xFFED7E1C);
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;
    
    if (_currentQuestion == _questions.length) {
      final riskLevel = _getRiskLevel();
      final riskDescription = _getRiskDescription(riskLevel);
      final riskColor = _getRiskColor(riskLevel);
      
      return Scaffold(
        appBar: AppBar(
          title: const Text('ASQ Assessment'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 24,
            children: [
              // Risk level display
              Container(
                padding: const EdgeInsets.all(24),
                decoration: ShapeDecoration(
                  color: riskColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Column(
                  spacing: 12,
                  children: [
                    Text(
                      'Suicide Risk Assessment',
                      style: theme.textTheme.titleMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: riskColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        riskDescription,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      'Items endorsed: $riskLevel of ${_questions.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // Critical info box
              if (riskLevel >= 2)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: Colors.red.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Colors.red.shade200,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning, color: Colors.red.shade900, size: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Important Notice',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Based on your responses, it\'s important to reach out to a mental health professional immediately. Your safety is our priority.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red.shade800,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: colors.primary.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: colors.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        '💡 Support Resources',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'If you ever have thoughts of suicide, please reach out to a mental health professional or crisis helpline.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

              // Crisis resources
              Container(
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text(
                      '🆘 Crisis Resources',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildResourceItem('National Suicide Prevention Lifeline', '1-800-273-8255', '24/7'),
                    _buildResourceItem('Crisis Text Line', 'Text HOME to 741741', 'Text-based support'),
                    _buildResourceItem('International Association for Suicide Prevention', 'https://www.iasp.info/resources/Crisis_Centres/', 'Global resources'),
                  ],
                ),
              ),

              // Action buttons
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12,
                  children: [
                    if (riskLevel >= 2)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/crisisSupport');
                        },
                        child: const Text(
                          'Get Immediate Help',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (widget.isClinicianFlow) {
                          Navigator.pop(context, {
                            'score': riskLevel,
                            'severity': riskDescription,
                            'answers': _answers,
                          });
                        } else {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: BorderSide(color: colors.primary),
                      ),
                      onPressed: () {
                        setState(() {
                          _currentQuestion = 0;
                          _answers.clear();
                          _pageController.jumpToPage(0);
                        });
                      },
                      child: Text(
                        'Retake Assessment',
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final progress = (_currentQuestion + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ASQ Assessment'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentQuestion + 1} of ${_questions.length}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ],
            ),
          ),

          // Questions
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentQuestion = index);
              },
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: 16,
                    children: [
                      AssessmentQuestionCard(
                        questionNumber: index + 1,
                        question: _questions[index],
                        options: _options,
                        selectedAnswer: _answers[index],
                        onAnswerSelected: (answer) {
                          setState(() => _answers[index] = answer);
                        },
                        accentColor: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _currentQuestion > 0
                      ? () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                      : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Previous'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _answers[_currentQuestion] != null
                      ? () {
                        if (_currentQuestion < _questions.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          setState(() => _currentQuestion++);
                        }
                      }
                      : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentQuestion == _questions.length - 1
                        ? 'Finish'
                        : 'Next',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
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

  Widget _buildResourceItem(String title, String value, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
