import 'package:flutter/material.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/twelfth_page/widgets/number_row.dart';

class TwelfthPage extends StatefulWidget {
  const TwelfthPage({super.key});

  @override
  State<TwelfthPage> createState() => _TwelfthPageState();
}

class _TwelfthPageState extends State<TwelfthPage> {
  int selectedIndex = 4;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    onTap(int index) {
      setState(() => selectedIndex = index);
    }

    return Column(
      spacing: 20,
      children: [
        Text(
          "${selectedIndex + 1}",
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 160,
            height: 0.9,
          ),
        ),
        NumberRow(theme: theme, selectedIndex: selectedIndex, onTap: onTap),
        Text(
          'You Are ${questions[selectedIndex]} Stressed Out',
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

final List<String> questions = [
  'Not at all',
  'Barely',
  'Moderately',
  'Highly',
  'Extremely',
];
