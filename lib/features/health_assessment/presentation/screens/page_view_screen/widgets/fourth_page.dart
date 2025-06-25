import 'package:flutter/material.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/weight_scrolling_widget.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/weight_switcher_widget.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  bool isLbs = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeightSwitcherWidget(
          isLbs: isLbs,
          setKg: () => setState(() => isLbs = false),
          setLbs: () => setState(() => isLbs = true),
        ),
        SizedBox(height: 60),
        WeightScrollingWidget(isLbs: isLbs),
      ],
    );
  }
}
