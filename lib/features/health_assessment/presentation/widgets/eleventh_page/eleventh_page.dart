import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/eleventh_page/widgets/custom_large_text_field.dart';
import 'package:vector_graphics/vector_graphics.dart';

class EleventhPage extends StatefulWidget {
  const EleventhPage({super.key});

  @override
  State<EleventhPage> createState() => _EleventhPageState();
}

class _EleventhPageState extends State<EleventhPage> {
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
    return Column(
      children: [
        SvgPicture(
          AssetBytesLoader(Theme.of(context).extension<CustomAssets>()!.page11),
          width: 207,
          height: 194,
        ),
        const SizedBox(height: SizesManager.padding),
        CustomLargeTextField(controller: _controller, hintText: ''),
      ],
    );
  }
}
