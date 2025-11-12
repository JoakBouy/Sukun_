import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/assessment_question_card.dart';

class DASS21AssessmentScreen extends StatefulWidget {
  const DASS21AssessmentScreen({super.key});

  @override
  State<DASS21AssessmentScreen> createState() => _DASS21AssessmentScreenState();
}

class _DASS21AssessmentScreenState extends State<DASS21AssessmentScreen> {
  final Map<int, String> _answers = {};
  late PageController _pageController;
  int _currentQuestion = 0;

  final List<String> _questions = [
    'I found it hard to wind down',
    'I was aware of dryness of my mouth',
    'I couldn\'t seem to experience any positive feeling at all',
    'I experienced breathing difficulty (eg, excessively rapid breathing, breathlessness in the absence of physical exertion)',
    'I found it difficult to work up the initiative to do things',
    'I tended to over-react to situations',
    'I experienced trembling (eg, in the hands)',
    'I felt that I was using a lot of nervous energy',
    'I was worried about situations in which I might panic and make a fool of myself',
    'I felt that I had nothing to look forward to',
    'I found myself getting agitated',
    'I found it difficult to relax',
    'I felt downhearted and blue',
    'I was intolerant of anything that kept me from getting on with what I was doing',
    'I felt I was close to panic',
    'I was unable to become enthusiastic about anything',
    'I felt I wasn\'t worth much as a person',
    'I felt that I was rather touchy',
    'I was aware of the action of my heart in the absence of physical exertion (eg, sense of heart rate increase, heart missing a beat)',
    'I felt scared without any good reason',
    'I felt that life was meaningless',
  ];

  final List<String> _options = ['Did not apply to me at all', 'Applied to me to some degree or some of the time', 'Applied to me to a considerable degree or a good part of the time', 'Applied to me very much or most of the time'];

  // Question categories: 0=D, 1=A, 2=S (for coloring)
  final List<int> _categories = [
    2, 1, 0, 1, 0, 2, 1, 1, 1, 0, 2, 2, 0, 2, 1, 0, 0, 2, 1, 1, 0,
  ];

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

  void _calculateScores() {
    int depressionScore = 0, anxietyScore = 0, stressScore = 0;
    
    for (int i = 0; i < _questions.length; i++) {
      final answer = _answers[i];
      if (answer != null) {
        final score = _options.indexOf(answer) * 2;
        
        if (_categories[i] == 0) depressionScore += score;
        else if (_categories[i] == 1) anxietyScore += score;
        else stressScore += score;
      }
    }
    
    _showResults(depressionScore, anxietyScore, stressScore);
  }

  void _showResults(int depression, int anxiety, int stress) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => _DASS21ResultsScreen(
          depressionScore: depression,
          anxietyScore: anxiety,
          stressScore: stress,
        ),
      ),
    );
  }

  Color _getCategoryColor(int category) {
    if (category == 0) return const Color(0xFF9BB068); // Depression - Green
    if (category == 1) return const Color(0xFFFE804B); // Anxiety - Red
    return const Color(0xFFED7E1C); // Stress - Orange
  }

  String _getCategoryLabel(int category) {
    if (category == 0) return 'Depression';
    if (category == 1) return 'Anxiety';
    return 'Stress';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;
    final progress = (_currentQuestion + 1) / _questions.length;
    final currentCategory = _categories[_currentQuestion];
    final categoryColor = _getCategoryColor(currentCategory);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DASS-21 Assessment'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Progress bar with category indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${_currentQuestion + 1} of ${_questions.length}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getCategoryLabel(currentCategory),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: categoryColor,
                            ),
                          ),
                        ),
                      ],
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
                    valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
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
                        accentColor: _getCategoryColor(_categories[index]),
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
                          _calculateScores();
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
}

class _DASS21ResultsScreen extends StatelessWidget {
  final int depressionScore;
  final int anxietyScore;
  final int stressScore;

  const _DASS21ResultsScreen({
    required this.depressionScore,
    required this.anxietyScore,
    required this.stressScore,
  });

  String _getLevel(int score, String category) {
    if (category == 'depression') {
      if (score < 10) return 'Normal';
      if (score < 14) return 'Mild';
      if (score < 21) return 'Moderate';
      if (score < 28) return 'Severe';
      return 'Extremely Severe';
    } else if (category == 'anxiety') {
      if (score < 8) return 'Normal';
      if (score < 10) return 'Mild';
      if (score < 15) return 'Moderate';
      if (score < 20) return 'Severe';
      return 'Extremely Severe';
    } else {
      if (score < 15) return 'Normal';
      if (score < 19) return 'Mild';
      if (score < 26) return 'Moderate';
      if (score < 34) return 'Severe';
      return 'Extremely Severe';
    }
  }

  Color _getScoreColor(int score, String category) {
    final level = _getLevel(score, category);
    if (level == 'Normal') return const Color(0xFF9BB068);
    if (level == 'Mild') return const Color(0xFFFFBD1A);
    if (level == 'Moderate') return const Color(0xFFED7E1C);
    if (level == 'Severe') return const Color(0xFFFE804B);
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DASS-21 Results'),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            // Overall results
            Text(
              'Your Results',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),

            // Three score cards
            Column(
              spacing: 16,
              children: [
                _buildScoreCard(
                  'Depression',
                  depressionScore,
                  _getLevel(depressionScore, 'depression'),
                  _getScoreColor(depressionScore, 'depression'),
                  theme,
                ),
                _buildScoreCard(
                  'Anxiety',
                  anxietyScore,
                  _getLevel(anxietyScore, 'anxiety'),
                  _getScoreColor(anxietyScore, 'anxiety'),
                  theme,
                ),
                _buildScoreCard(
                  'Stress',
                  stressScore,
                  _getLevel(stressScore, 'stress'),
                  _getScoreColor(stressScore, 'stress'),
                  theme,
                ),
              ],
            ),

            // Information box
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
                    '📋 About These Scores',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'The DASS-21 is a 21-item self-report questionnaire designed to measure the emotional states of depression, anxiety, and stress. Higher scores indicate greater severity.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Recommendations
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFFFEEFEA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                    color: Color(0xFFFE804B),
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
                      color: const Color(0xFFFE804B),
                    ),
                  ),
                  Text(
                    'We recommend discussing these results with a mental health professional who can provide personalized guidance and treatment options.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Action buttons
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Book a Consultation',
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

  Widget _buildScoreCard(
    String title,
    int score,
    String level,
    Color color,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
