import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/managers/theme_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/fourteenth_page/widgets/custom_large_text_field2.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/fourteenth_page/widgets/use_voice_button.dart';
import 'package:vector_graphics/vector_graphics.dart';

class FourteenthPage extends StatefulWidget {
  const FourteenthPage({super.key});

  @override
  State<FourteenthPage> createState() => _FourteenthPageState();
}

class _FourteenthPageState extends State<FourteenthPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: 30,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            StringsManager.assessmentSubtitle14,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox.shrink(),
        CustomLargeTextField2(
          controller: _controller,
          focusNode: _focusNode,
          hintText:
              'I don’t want to be         alive anymore. Just        f****** kill me, doc.',
        ),
        UseVoiceButton(theme: theme),
      ],
    );
  }
}
