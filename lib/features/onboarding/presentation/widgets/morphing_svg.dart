import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freud_ai/core/managers/assets_manager.dart';

class MorphingSvg extends StatefulWidget {
  final String isDarkMode;
  final int currentIndex;

  const MorphingSvg({
    super.key,
    required this.isDarkMode,
    required this.currentIndex,
  });

  @override
  MorphingSvgState createState() => MorphingSvgState();
}

class MorphingSvgState extends State<MorphingSvg> {
  late int _previousIndex;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant MorphingSvg oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentIndex != _previousIndex) {
      setState(() {
        _previousIndex = widget.currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: SizedBox(
        key: ValueKey<int>(widget.currentIndex),
        child: SvgPicture.asset(
          AssetsManager.getOnboarding(widget.isDarkMode, widget.currentIndex),
          allowDrawingOutsideViewBox: false,
        ),
      ),
    );
  }
}
