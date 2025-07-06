import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/second_page/widgets/gender_card_widget.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _selectedValue = 1),
            child: GenderCardWidget(
              isSelected: _selectedValue == 1,
              isMale: true,
            ),
          ),
          const SizedBox(height: SizesManager.hPadding),
          GestureDetector(
            onTap: () => setState(() => _selectedValue = 2),
            child: GenderCardWidget(
              isSelected: _selectedValue == 2,
              isMale: false,
            ),
          ),
        ],
      ),
    );
  }
}
