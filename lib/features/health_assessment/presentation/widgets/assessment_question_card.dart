import 'package:flutter/material.dart';

/// Reusable question card for assessments
class AssessmentQuestionCard extends StatelessWidget {
  final int questionNumber;
  final String question;
  final List<String> options;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;
  final Color accentColor;

  const AssessmentQuestionCard({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.options,
    this.selectedAnswer,
    required this.onAnswerSelected,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          // Question number and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Question ${questionNumber}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
              ),
              Text(
                question,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          // Options
          Column(
            spacing: 12,
            children: List.generate(
              options.length,
              (index) => _OptionButton(
                label: options[index],
                isSelected: selectedAnswer == options[index],
                accentColor: accentColor,
                onTap: () => onAnswerSelected(options[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: ShapeDecoration(
          color: isSelected 
            ? accentColor.withOpacity(0.1)
            : Colors.grey.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isSelected ? accentColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(
                    width: 2,
                    color: isSelected ? accentColor : Colors.grey.shade300,
                  ),
                ),
              ),
              child: isSelected
                ? Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: ShapeDecoration(
                      color: accentColor,
                      shape: const OvalBorder(),
                    ),
                  ),
                )
                : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected
                    ? accentColor
                    : Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
