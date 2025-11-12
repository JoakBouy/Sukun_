import 'package:flutter/material.dart';

/// Custom notification bell icon matching the reference design
class CustomNotificationIcon extends StatelessWidget {
  final double size;
  final Color color;

  const CustomNotificationIcon({
    super.key,
    this.size = 24,
    this.color = const Color(0xFF4B3425),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Bell shape - rotated oval
          Positioned(
            left: size * 0.125, // 3 for size 24
            top: size * 0.083, // 2 for size 24
            child: Transform.rotate(
              angle: 3.14, // 180 degrees
              child: Container(
                width: size * 0.75, // 18 for size 24
                height: size * 0.75, // 18 for size 24
                decoration: ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(
                      width: size * 0.083, // 2 for size 24
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bell clapper/handle
          Positioned(
            left: size * 0.375, // 9 for size 24
            top: size * 0.167, // 4 for size 24
            child: Container(
              width: size * 0.083, // 2 for size 24
              height: size * 0.083, // 2 for size 24
              decoration: ShapeDecoration(
                color: color,
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: size * 0.542, // 13 for size 24
            top: size * 0.167, // 4 for size 24
            child: Container(
              width: size * 0.083, // 2 for size 24
              height: size * 0.083, // 2 for size 24
              decoration: ShapeDecoration(
                color: color,
                shape: OvalBorder(),
              ),
            ),
          ),
          // Bell base
          Positioned(
            left: size * 0.333, // 8 for size 24
            top: size * 0.667, // 16 for size 24
            child: Transform.rotate(
              angle: -1.57, // -90 degrees
              child: Container(
                width: size * 0.75, // 18 for size 24
                height: size * 0.333, // 8 for size 24
                decoration: ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(
                      width: size * 0.083, // 2 for size 24
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
