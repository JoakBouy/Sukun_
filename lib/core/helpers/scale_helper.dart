import 'package:flutter/material.dart';

class ScaleHelper {
  static double calculate(Size size) {
    return size.height / 10 < 70
        ? 0.8
        : size.aspectRatio > 1
        ? 1
        : size.height > 1500
        ? size.aspectRatio * 3
        : size.aspectRatio * 2;
  }
}
