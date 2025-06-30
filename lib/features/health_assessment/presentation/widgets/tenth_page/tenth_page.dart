import 'package:flutter/material.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/tenth_page/data/english_words.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/tenth_page/widgets/alphabetical_bar.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/tenth_page/widgets/medications_list.dart';

class TenthPage extends StatefulWidget {
  const TenthPage({super.key});

  @override
  State<TenthPage> createState() => _TenthPageState();
}

class _TenthPageState extends State<TenthPage> {
  final ScrollController _scrollController = ScrollController();
  final alphabetWords = generateAlphabeticalWords();
  void scrollToLetter(int i) => setState(() {
    _scrollController.animateTo(
      (i * 320),
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      spacing: 10,
      children: [
        AlphabeticalBar(theme: theme, scroll: scrollToLetter),
        MedicationsList(
          theme: theme,
          alphabetWords: alphabetWords,
          scrollController: _scrollController,
        ),
      ],
    );
  }
}
