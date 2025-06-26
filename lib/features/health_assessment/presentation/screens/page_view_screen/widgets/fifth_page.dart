import 'package:flutter/material.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/emoji_wheel_widget.dart';

class FifthPage extends StatefulWidget {
  const FifthPage({super.key});

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [EmojiWheelWidget()]);
  }
}
