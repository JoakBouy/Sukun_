import 'package:flutter/material.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/data/models/sleep_time_item.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eighth_page/widgets/sleep_time_child.dart';

class SleepTimeColumn extends StatelessWidget {
  const SleepTimeColumn({super.key, required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            sleepTimeItems.length,
            (index) => SleepTimeChild(
              item: sleepTimeItems[index],
              isSelected: index == 4 - value,
            ),
          ),
        ],
      ),
    );
  }
}

List<SleepTimeItem> sleepTimeItems = [
  SleepTimeItem(title: 'Excellent', subtitle: '7-9 HOURS'),
  SleepTimeItem(title: 'Good', subtitle: '6-7 HOURS'),
  SleepTimeItem(title: 'Fair', subtitle: '5 HOURS'),
  SleepTimeItem(title: 'Poor', subtitle: '3-4 HOURS'),
  SleepTimeItem(title: 'Worst', subtitle: '< 3 HOURS'),
];
