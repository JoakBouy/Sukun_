import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:vector_graphics/vector_graphics.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start loading
    _timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      setState(() {
        _progress += 1;
        if (_progress > 98) {
          _progress = 99;
          _timer?.cancel();
          // go to next screen
          Future.delayed(Duration(milliseconds: 300), () {
            if (mounted) {
              Navigator.pushReplacementNamed(
                context,
                NavigationManager.endingScreen,
              );
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            OverflowBox(
              alignment: Alignment.center,
              maxHeight: 1100,
              maxWidth: 1100,
              child: SvgPicture(
                AssetBytesLoader(theme.extension<CustomAssets>()!.iconWhite),
                width: 2000,
                height: 2000,
                colorFilter: ColorFilter.mode(
                  const Color(0xff4c3422),
                  BlendMode.srcIn,
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '$_progress',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                children: [
                  TextSpan(
                    text: '%',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.extension<CustomColors>()!.lightPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
