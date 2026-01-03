import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

/// Today's goals checklist widget
class TodaysGoals extends StatefulWidget {
  const TodaysGoals({super.key});

  @override
  State<TodaysGoals> createState() => _TodaysGoalsState();
}

class _TodaysGoalsState extends State<TodaysGoals> {
  final List<Map<String, dynamic>> _goals = [
    {'title': 'Morning meditation', 'completed': true, 'icon': Icons.self_improvement},
    {'title': 'Journal entry', 'completed': false, 'icon': Icons.edit_note},
    {'title': 'Breathing exercise', 'completed': false, 'icon': Icons.air},
    {'title': 'Evening check-in', 'completed': false, 'icon': Icons.nightlight},
  ];

  int get _completedCount => _goals.where((g) => g['completed'] == true).length;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final progress = _completedCount / _goals.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Goals',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: colors.primary,
                  fontFamily: 'urbanist',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.greenAccent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  '$_completedCount/${_goals.length}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colors.green,
                    fontFamily: 'urbanist',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: colors.greyAccent,
              valueColor: AlwaysStoppedAnimation<Color>(colors.green),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 20),

          // Goals list
          ...List.generate(_goals.length, (index) {
            final goal = _goals[index];
            final isCompleted = goal['completed'] as bool;
            
            return Padding(
              padding: EdgeInsets.only(bottom: index < _goals.length - 1 ? 12 : 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _goals[index]['completed'] = !isCompleted;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isCompleted ? colors.green : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isCompleted ? colors.green : colors.grey,
                          width: 2,
                        ),
                      ),
                      child: isCompleted
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      goal['icon'] as IconData,
                      size: 20,
                      color: isCompleted
                          ? colors.green
                          : colors.onBackground.withOpacity(0.5),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      goal['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isCompleted
                            ? colors.onBackground.withOpacity(0.5)
                            : colors.primary,
                        fontFamily: 'urbanist',
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
