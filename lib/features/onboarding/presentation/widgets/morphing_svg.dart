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
  late Size size;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: Padding(
        key: ValueKey<int>(widget.currentIndex),
        padding: EdgeInsets.only(bottom: size.height / 3.3),
        child: OverflowBox(
          alignment: Alignment.bottomCenter,
          maxWidth: size.width * 2,
          maxHeight: size.height * 2,
          child: SvgPicture.asset(
            fit: BoxFit.fitWidth,
            AssetsManager.getOnboarding(widget.isDarkMode, widget.currentIndex),
            allowDrawingOutsideViewBox: false,
          ),
        ),
      ),
    );
  }
}
