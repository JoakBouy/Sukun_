import 'package:flutter/material.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/tenth_page/widgets/alphabetical_bar.dart';

class TenthPage extends StatefulWidget {
  const TenthPage({super.key});

  @override
  State<TenthPage> createState() => _TenthPageState();
}

class _TenthPageState extends State<TenthPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(children: [AlphabeticalBar(theme: theme)]);
  }
}
