import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/assessment_question_card.dart';

class PHQ9AssessmentScreen extends StatefulWidget {
  const PHQ9AssessmentScreen({super.key});

  @override
  State<PHQ9AssessmentScreen> createState() => _PHQ9AssessmentScreenState();
}

class _PHQ9AssessmentScreenState extends State<PHQ9AssessmentScreen> {
  final Map<int, String> _answers = {};
  late PageController _pageController;
  int _currentQuestion = 0;

  final List<String> _questions = [
    'Little interest or pleasure in doing things',
    'Feeling down, depressed, or hopeless',
    'Trouble falling or staying asleep, or sleeping too much',
    'Feeling tired or having little energy',
    'Poor appetite or overeating',
    'Feeling bad about yourself or that you are a failure or have let your family down',
    'Trouble concentrating on things, such as reading the newspaper or watching television',
    'Moving or speaking so slowly that other people could have noticed; or the opposite, being so fidgety or restless that you have been moving around a lot more than usual',
    'Thoughts that you would be better off dead or of hurting yourself',
  ];

  final List<String> _options = ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'];

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

  int _calculateScore() {
    int score = 0;
    for (var answer in _answers.values) {
      score += _options.indexOf(answer);
    }
    return score;
  }

  String _getDepressionLevel(int score) {
    if (score <= 4) return 'Minimal';
    if (score <= 9) return 'Mild';
    if (score <= 14) return 'Moderate';
    if (score <= 19) return 'Moderately Severe';
    return 'Severe';
  }

  Color _getScoreColor(int score) {
    if (score <= 4) return const Color(0xFF9BB068); // Green
    if (score <= 9) return const Color(0xFFFFBD1A); // Yellow
    if (score <= 14) return const Color(0xFFED7E1C); // Orange
    if (score <= 19) return const Color(0xFFFE804B); // Red-Orange
    return Colors.red; // Red
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;
    
    if (_currentQuestion == _questions.length) {
      final score = _calculateScore();
      final level = _getDepressionLevel(score);
      final scoreColor = _getScoreColor(score);
      
      return Scaffold(
        appBar: AppBar(
          title: const Text('PHQ-9 Assessment'),
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
              // Score display
              Container(
                padding: const EdgeInsets.all(24),
                decoration: ShapeDecoration(
                  color: scoreColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Column(
                  spacing: 12,
                  children: [
                    Text(
                      'Your PHQ-9 Score',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      score.toString(),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: scoreColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: scoreColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        level,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Score ranges
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
                      'Score Ranges:',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildScoreRange('0-4', 'Minimal depression', const Color(0xFF9BB068)),
                    _buildScoreRange('5-9', 'Mild depression', const Color(0xFFFFBD1A)),
                    _buildScoreRange('10-14', 'Moderate depression', const Color(0xFFED7E1C)),
                    _buildScoreRange('15-19', 'Moderately severe depression', const Color(0xFFFE804B)),
                    _buildScoreRange('20+', 'Severe depression', Colors.red),
                  ],
                ),
              ),

              // Recommendations
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
                      '💡 Next Steps',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Consider scheduling a consultation with a mental health professional to discuss your results and develop a treatment plan.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: Column(
                  spacing: 12,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
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
        title: const Text('PHQ-9 Assessment'),
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
                    valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
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
                        accentColor: const Color(0xFF9BB068), // Green for PHQ-9
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

  Widget _buildScoreRange(String range, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '$range: $label',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
