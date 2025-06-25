import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';

class MorphingSvg extends StatefulWidget {
  final int currentIndex;

  const MorphingSvg({super.key, required this.currentIndex});

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
    final ThemeData theme = Theme.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: OverflowBox(
        alignment: Alignment.topCenter,
        maxWidth: size.width * 2,
        child: SvgPicture.asset(
          width: size.height * 0.9,
          getSvg(widget.currentIndex, theme),
          allowDrawingOutsideViewBox: false,
        ),
      ),
    );
  }
}

getSvg(int index, ThemeData theme) {
  switch (index) {
    case 1:
      return theme.extension<CustomAssets>()!.onboarding1;
    case 2:
      return theme.extension<CustomAssets>()!.onboarding2;
    case 3:
      return theme.extension<CustomAssets>()!.onboarding3;
    case 4:
      return theme.extension<CustomAssets>()!.onboarding4;
    case 5:
      return theme.extension<CustomAssets>()!.onboarding5;
    default:
      return '';
  }
}
