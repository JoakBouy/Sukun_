import 'package:flutter/material.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/third_page/age_widget.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final CarouselController _controller = CarouselController(initialItem: 17);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AgeWidget(controller: _controller);
  }
}
