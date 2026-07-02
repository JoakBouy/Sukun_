import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/assessment_question_card.dart';

class GAD7AssessmentScreen extends StatefulWidget {
  const GAD7AssessmentScreen({super.key});
  @override
  State<GAD7AssessmentScreen> createState() => _GAD7State();
}

class _GAD7State extends State<GAD7AssessmentScreen> {
  final Map<int, String> _answers = {};
  late PageController _pageController;
  int _currentQuestion = 0;

  final _questions = [
    'Feeling nervous, anxious, or on edge',
    'Not being able to stop or control worrying',
    'Worrying too much about different things',
    'Trouble relaxing',
    'Being so restless that it is hard to sit still',
    'Becoming easily annoyed or irritable',
    'Feeling afraid, as if something awful might happen',
  ];

  final _options = ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'];

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

  int _score() => _answers.values.fold(0, (sum, a) => sum + _options.indexOf(a));

  String _severity(int score) {
    if (score <= 4) return 'Minimal';
    if (score <= 9) return 'Mild';
    if (score <= 14) return 'Moderate';
    return 'Severe';
  }

  Color _color(int score) {
    if (score <= 4) return const Color(0xFF9BB068);
    if (score <= 9) return const Color(0xFFFFBD1A);
    if (score <= 14) return const Color(0xFFED7E1C);
    return CustomColors.primetelRed;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;
    const accent = Color(0xFFED7E1C);

    if (_currentQuestion == _questions.length) {
      final score = _score();
      return _ResultView(
        title: 'GAD-7 Results',
        assessmentType: 'GAD7',
        score: score,
        outOf: 21,
        severity: _severity(score),
        scoreColor: _color(score),
        answers: _answers,
        ranges: const [
          ('0–4', 'Minimal anxiety', Color(0xFF9BB068)),
          ('5–9', 'Mild anxiety', Color(0xFFFFBD1A)),
          ('10–14', 'Moderate anxiety', Color(0xFFED7E1C)),
          ('15–21', 'Severe anxiety', Color(0xFFC82828)),
        ],
        onRetake: () => setState(() { _currentQuestion = 0; _answers.clear(); _pageController.jumpToPage(0); }),
      );
    }

    return _QuestionView(
      title: 'GAD-7 Anxiety',
      accent: accent,
      currentQuestion: _currentQuestion,
      total: _questions.length,
      questions: _questions,
      options: _options,
      answers: _answers,
      pageController: _pageController,
      onAnswerSelected: (i, a) => setState(() => _answers[i] = a),
      onPageChanged: (i) => setState(() => _currentQuestion = i),
      onFinish: () => setState(() => _currentQuestion++),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class PCL5AssessmentScreen extends StatefulWidget {
  const PCL5AssessmentScreen({super.key});
  @override
  State<PCL5AssessmentScreen> createState() => _PCL5State();
}

class _PCL5State extends State<PCL5AssessmentScreen> {
  final Map<int, String> _answers = {};
  late PageController _pageController;
  int _currentQuestion = 0;

  final _questions = [
    'Repeated, disturbing, and unwanted memories of the stressful experience',
    'Repeated, disturbing dreams of the stressful experience',
    'Suddenly feeling or acting as if the stressful experience were actually happening again',
    'Feeling very upset when something reminded you of the stressful experience',
    'Having strong physical reactions when something reminded you of the stressful experience',
    'Avoiding memories, thoughts, or feelings related to the stressful experience',
    'Avoiding external reminders of the stressful experience',
    'Trouble remembering important parts of the stressful experience',
    'Having strong negative beliefs about yourself, other people, or the world',
    'Blaming yourself or someone else for the stressful experience or what happened after it',
    'Having strong negative feelings such as fear, horror, anger, guilt, or shame',
    'Loss of interest in activities that you used to enjoy',
    'Feeling distant or cut off from other people',
    'Trouble experiencing positive feelings',
    'Irritable behavior, angry outbursts, or acting aggressively',
    'Taking too many risks or doing things that could cause you harm',
    'Being "super-alert" or watchful or on guard',
    'Feeling jumpy or easily startled',
    'Having difficulty concentrating',
    'Trouble falling or staying asleep',
  ];

  final _options = ['Not at all', 'A little bit', 'Moderately', 'Quite a bit', 'Extremely'];

  @override
  void initState() { super.initState(); _pageController = PageController(); }
  @override
  void dispose() { _pageController.dispose(); super.dispose(); }

  int _score() => _answers.values.fold(0, (sum, a) => sum + _options.indexOf(a));

  String _severity(int score) {
    if (score < 33) return 'Below Threshold';
    if (score < 50) return 'Moderate PTSD';
    if (score < 70) return 'Severe PTSD';
    return 'Extreme PTSD';
  }

  Color _color(int score) {
    if (score < 33) return const Color(0xFF9BB068);
    if (score < 50) return const Color(0xFFED7E1C);
    if (score < 70) return CustomColors.primetelRed;
    return CustomColors.primetelRedDark;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const accent = Color(0xFFFFBD1A);

    if (_currentQuestion == _questions.length) {
      final score = _score();
      return _ResultView(
        title: 'PCL-5 Results',
        assessmentType: 'PCL5',
        score: score,
        outOf: 80,
        severity: _severity(score),
        scoreColor: _color(score),
        answers: _answers,
        ranges: const [
          ('0–32', 'Below clinical threshold', Color(0xFF9BB068)),
          ('33–49', 'Moderate PTSD symptoms', Color(0xFFED7E1C)),
          ('50–69', 'Severe PTSD symptoms', Color(0xFFC82828)),
          ('70–80', 'Extreme PTSD symptoms', Color(0xFF8B1A1A)),
        ],
        onRetake: () => setState(() { _currentQuestion = 0; _answers.clear(); _pageController.jumpToPage(0); }),
      );
    }

    return _QuestionView(
      title: 'PCL-5 Trauma',
      accent: accent,
      currentQuestion: _currentQuestion,
      total: _questions.length,
      questions: _questions,
      options: _options,
      answers: _answers,
      pageController: _pageController,
      onAnswerSelected: (i, a) => setState(() => _answers[i] = a),
      onPageChanged: (i) => setState(() => _currentQuestion = i),
      onFinish: () => setState(() => _currentQuestion++),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class SRQ20AssessmentScreen extends StatefulWidget {
  const SRQ20AssessmentScreen({super.key});
  @override
  State<SRQ20AssessmentScreen> createState() => _SRQ20State();
}

class _SRQ20State extends State<SRQ20AssessmentScreen> {
  final Map<int, String> _answers = {};
  late PageController _pageController;
  int _currentQuestion = 0;

  final _questions = [
    'Do you often have headaches?',
    'Is your appetite poor?',
    'Do you sleep badly?',
    'Are you easily frightened?',
    'Do your hands shake?',
    'Do you feel nervous, tense or worried?',
    'Is your digestion poor?',
    'Do you have trouble thinking clearly?',
    'Do you feel unhappy?',
    'Do you cry more than usual?',
    'Do you find it difficult to enjoy your daily activities?',
    'Do you find it difficult to make decisions?',
    'Is your daily work suffering?',
    'Are you unable to play a useful part in life?',
    'Have you lost interest in things?',
    'Do you feel that you are a worthless person?',
    'Has the thought of ending your life been on your mind?',
    'Do you feel tired all the time?',
    'Do you have uncomfortable feelings in your stomach?',
    'Are you easily tired?',
  ];

  final _options = ['No', 'Yes'];

  @override
  void initState() { super.initState(); _pageController = PageController(); }
  @override
  void dispose() { _pageController.dispose(); super.dispose(); }

  int _score() => _answers.values.fold(0, (sum, a) => sum + (a == 'Yes' ? 1 : 0));

  String _severity(int score) {
    if (score < 8) return 'Below Threshold';
    if (score < 12) return 'Probable CMD';
    return 'Likely CMD';
  }

  Color _color(int score) {
    if (score < 8) return const Color(0xFF9BB068);
    if (score < 12) return const Color(0xFFED7E1C);
    return CustomColors.primetelRed;
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF9BB068);

    if (_currentQuestion == _questions.length) {
      final score = _score();
      return _ResultView(
        title: 'SRQ-20 Results',
        assessmentType: 'SRQ20',
        score: score,
        outOf: 20,
        severity: _severity(score),
        scoreColor: _color(score),
        answers: _answers,
        ranges: const [
          ('0–7', 'Below threshold', Color(0xFF9BB068)),
          ('8–11', 'Probable common mental disorder', Color(0xFFED7E1C)),
          ('12–20', 'Likely common mental disorder', Color(0xFFC82828)),
        ],
        onRetake: () => setState(() { _currentQuestion = 0; _answers.clear(); _pageController.jumpToPage(0); }),
        note: 'WHO cut-off: ≥8 indicates probable common mental disorder (CMD). Validated for sub-Saharan African populations.',
      );
    }

    return _QuestionView(
      title: 'SRQ-20 (WHO)',
      accent: accent,
      currentQuestion: _currentQuestion,
      total: _questions.length,
      questions: _questions,
      options: _options,
      answers: _answers,
      pageController: _pageController,
      onAnswerSelected: (i, a) => setState(() => _answers[i] = a),
      onPageChanged: (i) => setState(() => _currentQuestion = i),
      onFinish: () => setState(() => _currentQuestion++),
    );
  }
}

// ── Shared Question View Widget ───────────────────────────────────────────────

class _QuestionView extends StatelessWidget {
  final String title;
  final Color accent;
  final int currentQuestion;
  final int total;
  final List<String> questions;
  final List<String> options;
  final Map<int, String> answers;
  final PageController pageController;
  final void Function(int, String) onAnswerSelected;
  final void Function(int) onPageChanged;
  final VoidCallback onFinish;

  const _QuestionView({
    required this.title,
    required this.accent,
    required this.currentQuestion,
    required this.total,
    required this.questions,
    required this.options,
    required this.answers,
    required this.pageController,
    required this.onAnswerSelected,
    required this.onPageChanged,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;
    final progress = (currentQuestion + 1) / total;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Progress
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Question ${currentQuestion + 1} of $total',
                        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                    Text('${(progress * 100).toInt()}%',
                        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(accent),
                  ),
                ),
              ],
            ),
          ),

          // Questions
          Expanded(
            child: PageView.builder(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: onPageChanged,
              itemCount: total,
              itemBuilder: (ctx, index) => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: AssessmentQuestionCard(
                  questionNumber: index + 1,
                  question: questions[index],
                  options: options,
                  selectedAnswer: answers[index],
                  onAnswerSelected: (a) => onAnswerSelected(index, a),
                  accentColor: accent,
                ),
              ),
            ),
          ),

          // Navigation
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: currentQuestion > 0
                        ? () => pageController.previousPage(
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                        : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: answers[currentQuestion] != null
                        ? () {
                            if (currentQuestion < total - 1) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                            } else {
                              onFinish();
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(
                      currentQuestion == total - 1 ? 'Finish' : 'Next',
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

// ── Shared Result View Widget ─────────────────────────────────────────────────

class _ResultView extends StatelessWidget {
  final String title;
  final String assessmentType;
  final int score;
  final int outOf;
  final String severity;
  final Color scoreColor;
  final Map<int, String> answers;
  final List<(String, String, Color)> ranges;
  final VoidCallback onRetake;
  final String? note;

  const _ResultView({
    required this.title,
    required this.assessmentType,
    required this.score,
    required this.outOf,
    required this.severity,
    required this.scoreColor,
    required this.answers,
    required this.ranges,
    required this.onRetake,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 0, backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Score
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: scoreColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: scoreColor.withOpacity(0.25)),
              ),
              child: Column(
                children: [
                  Text('Score', style: theme.textTheme.titleSmall?.copyWith(color: colors.onBackground.withOpacity(0.6))),
                  const SizedBox(height: 8),
                  Text('$score / $outOf',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: scoreColor)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(color: scoreColor, borderRadius: BorderRadius.circular(20)),
                    child: Text(severity,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ranges
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Score Ranges', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...ranges.map((r) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(width: 12, height: 12,
                            decoration: BoxDecoration(color: r.$3, shape: BoxShape.circle)),
                        const SizedBox(width: 10),
                        Text('${r.$1}:', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(width: 6),
                        Expanded(child: Text(r.$2, style: const TextStyle(fontSize: 13))),
                      ],
                    ),
                  )),
                ],
              ),
            ),

            if (note != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.green.withOpacity(0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: colors.green, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(note!, style: TextStyle(fontSize: 12, color: colors.onBackground.withOpacity(0.7)))),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onRetake,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Retake'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, {
                      'score': score,
                      'severity': severity,
                      'answers': answers,
                    }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primetelRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Save & Return', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
